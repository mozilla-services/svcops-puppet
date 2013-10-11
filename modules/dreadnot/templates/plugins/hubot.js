/*
 *  Copyright 2011 Rackspace
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */

var async = require('async');
var log = require('logmagic').local('plugins.hubot');
var irc = require('irc');

var sprintf = require('util/sprintf');
var git = require('util/git');
var spawn = require('util/misc').spawn;

function notify(msg) {
    spawn(["/usr/bin/pushbotnotify", msg], {}, function(err, stdout, stderr) {});
}

exports.run = function(dreadnot) {
  var clients = {},
      joined = {},
      config = dreadnot.config.plugins.hubot;

  dreadnot.emitter.on('deployments', function(deployment) {
    var link = sprintf('%s/stacks/%s/regions/%s/deployments/%s', dreadnot.config.default_url, deployment.stack, deployment.region,
                          deployment.deployment),
        msg = sprintf('%s is deploying %s to %s:%s - %s', deployment.user, deployment.stack, dreadnot.config.env,
                          deployment.region, link),
        endPath = ['stacks', deployment.stack, 'regions', deployment.region, 'deployments', deployment.deployment, 'end'].join('.'),
        i;

    if(deployment.user !== 'webdeployer') {
      notify(msg); 
    }

    dreadnot.emitter.once(endPath, function(success) {
      var stackConfig = dreadnot.config.stacks[deployment.stack];
      git.revParse(stackConfig.project_dir, deployment.to_revision, function(err, gitRef) {
        var endMsg = sprintf('<%%s> %s:%s to %s:%s %s', deployment.deployment, deployment.stack, git.trimRevision(gitRef), dreadnot.config.env,
                              deployment.region, success ? irc.colors.wrap('light_green', 'OK') : irc.colors.wrap('dark_red', 'FAIL'));
        if(!success) {
          endMsg = sprintf('%s - %s', endMsg, link);
        }
        notify(endMsg);
      });
    });
  });
};
