# includes repos needed for vagrant
class base::yum::vagrant {
  include base::yum::conf
  yumrepo {
    'mysql56-community':
      baseurl  => 'http://repo.mysql.com/yum/mysql-5.6-community/el/6/$basearch/',
      descr    => 'MySQL 5.6 Community Server',
      enabled  => 1,
  }
  yumrepo {
    'nginx-upstream':
      baseurl  => 'http://nginx.org/packages/OS/OSRELEASE/$basearch/',
      descr    => 'nginx',
      enabled  => 1,
  }
  yumrepo {
    'elasticsearch-0.90':
      baseurl  => 'http://packages.elasticsearch.org/elasticsearch/0.90/centos',
      descr    => 'Elasticsearch repository for 0.90.x packages',
      enabled  => 1,
  }
}
