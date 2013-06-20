#!/usr/bin/python2.6

import json
import socket
import sys
import time

from subprocess import Popen, PIPE
from telnetlib import Telnet


GMETRIC = "/usr/bin/gmetric"

PREFIX = "redis_%s" % sys.argv[1]
PORT = sys.argv[2]

STATE_FILE = "/tmp/redis_ganglia_%s.state" % PORT


class Metric(object):

    def __init__(self, name, units='count'):
        self.name = name
        self.units = units
        self.type = 'uint32'
        self.time = None
        self.prev_value = None
        self.prev_time = None

    def run_gmetric(self):
        cmd = [GMETRIC, '-t', self.type, '-u', self.units,
                        '-n', self.display_name, '-v', str(self.value())]
        Popen(cmd).communicate()

    @property
    def display_name(self):
        return "%s_%s" % (PREFIX, self.name)

    def value(self):
        return stats.get(self.name, '0')

    def set_time(self, time):
        self.time = time

    def load_prev_state(self, state):
        self.prev_time = state.get('time')
        self.prev_value = state.get(self.name)
        
    def save_state(self):
        return self.value()


class CounterMetric(Metric):

    def value(self):
        cur = int(stats.get(self.name, '0'))
        if not self.prev_time or not self.prev_value:
            return '0'


        minutes_passed = (self.time - self.prev_time) / 60
        if minutes_passed > 0 and cur > self.prev_value:
            return str(int((cur - self.prev_value) / minutes_passed))

        return '0'

    def save_state(self):
        return int(stats.get(self.name, '0'))
        
        
def get_redis_info(host='localhost', port=6379):
    c = Telnet(host, int(port))
    c.write("INFO\r\n")
    out = c.read_until("\r\n\r\n").split("\r\n")

    stats = {}
    for l in out:
        try:
            name, val = l.split(":")
        except ValueError:
            pass
        else:
            stats[name] = val

    return stats


METRICS = [
    Metric('connected_clients', units='clients'),
    Metric('connected_slaves', units='slaves'),
    Metric('blocked_clients', units='clients'),
    Metric('uptime_in_days', units='days'),
    Metric('used_memory', units='bytes'),
    Metric('changes_since_last_save', units='changes'),
    CounterMetric('total_connections_received', units='connections/min'),
    CounterMetric('total_commands_processed', units='processed/min'),
    Metric('expired_keys', units='keys'),
]

try: 
    stats = get_redis_info(port=PORT)
except socket.error:
    sys.exit(1)

state = {}
state['time'] = time.time()

try:
    with open(STATE_FILE) as f:
        prev_state = json.load(f)
except (IOError, ValueError):
    prev_state = {}

for m in METRICS:
    m.load_prev_state(prev_state)
    m.set_time(state['time'])
    m.run_gmetric()
    state[m.name] = m.save_state()

with open(STATE_FILE, 'w') as f:
    json.dump(state, f)
