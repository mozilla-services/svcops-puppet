class pushgo::nginx {
  class {
    '::nginx':
      nginx_conf => template('pushgo/nginx.conf');
  }
}
