# marketplace packages for celery
class marketplace::apps::zamboni::packages::celery {
    include marketplace::virtual_packages
    realize Package[
                    'totem'
    ]
}
