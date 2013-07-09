import os

ROOT = os.path.abspath(os.path.dirname(__file__))
def path(*a):
    return os.path.join(ROOT, *a)


# Set to True if this is a local development instance.
DEV = <%= is_dev %>

# Absolute path to the geoip binary data file.
GEO_DB_PATH = path('<%= geo_db_path %>')

# Allow POSTing of arbitrary IPs to get their location. This setting can not be
# enabled on public facing sites due to licensing restrictions on the MaxMind
# dataset.
ALLOW_POST = <%= allow_post %>
