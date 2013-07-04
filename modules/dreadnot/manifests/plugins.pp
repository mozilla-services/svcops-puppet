#dreadnot plugins
class dreadnot::plugins {
    file {
        "${dreadnot::root}/lib/plugins/hubot.js":
            require => Package['dreadnot'],
            content => template('dreadnot/plugins/hubot.js');
    }
}
