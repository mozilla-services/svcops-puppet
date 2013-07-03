#dreadnot plugins
class dreadnot::plugins {
    file {
        "${dreadnot::root}/lib/plugins/hubot.js":
            content => template('dreadnot/plugins/hubot.js');
    }
}
