#!/usr/bin/python

import hashlib
import os
import sys

from boto.s3.connection import S3Connection


S3PREFIX = ""

try:
    S3PREFIX = sys.argv[1]
except IndexError:
    pass

ACCESS_KEY = '<%= aws_access_key %>'
SECRET_KEY = '<%= aws_secret_key %>'
BUCKET = '<%= bucket %>'
FILE_PREFIX = '<%= file_prefix %>'

s3 = S3Connection(ACCESS_KEY, SECRET_KEY)
bucket = s3.get_bucket(BUCKET)

keys = [x for x in bucket.list() if x.name.startswith(S3PREFIX)]
idx_name_hash = set(((x.name, x.etag.strip('"')) for x in keys))
idx_name = set((x.name for x in keys))


def matches(s3loc, filename):
    if s3loc not in idx_name:
        return False

    idx_name.remove(s3loc)

    file_md5 = hashlib.md5(open(filename).read()).hexdigest()

    if (s3loc, file_md5) in idx_name_hash:
        return True

    return False


locs = set()
for path in (x.strip() for x in sys.stdin):
    if not os.path.isfile(path):
        continue

    loc = os.path.join(S3PREFIX, os.path.relpath(path, FILE_PREFIX))
    locs.add(loc)
    if matches(loc, path):
        print "Got match:", loc, path
        continue

    k = bucket.new_key(loc)
    k.set_contents_from_filename(path)
    print "Uploaded:", loc

if idx_name:
    print "Deleting %d files from s3." % len(idx_name)
    bucket.delete_keys(list(idx_name))
