import glob
import json

import pushbotnotify

OUTPUT_DIR = '<%= installdir %>/logs'

REDIS_BACKENDS = {
    'master': {
        'host': '<%= redis_host %>',
        'port': <%= redis_port %>,
        'password': None,
        'db': 0,
        'socket_timeout': 0.1,
    },
}

NOTIFIER_ENDPOINT = '<%= notifier_endpoint %>'
NOTIFIER_KEY = '<%= notifier_key %>'

NOTIFIERS = [pushbotnotify.Notifier(NOTIFIER_ENDPOINT, NOTIFIER_KEY).notify]

WEBAPPS = {}

for f in glob.glob('<%= installdir %>/webapps.d/*.json'):
    webapp = json.load(open(f))
    WEBAPPS[webapp['name']] = {
        'script': webapp['script'],
        'pubsub_channel': webapp['pubsub_channel'],
        'password': webapp['password']
    }

LOG_ROOT = '<%= log_root %>'
