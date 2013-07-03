var exec = require('child_process').exec;

var async = require('async');

var BuildBot = require('util/buildbot').BuildBot;
var knife = require('util/knife');
var misc = require('util/misc');
var sprintf = require('util/sprintf');
var git = require('util/git');


exports.get_deployedRevision = function(args, callback) {
  git.revParse(this.stackConfig.project_dir, 'HEAD', function(err, stdout) {
    // trim leading and trailing whitespace
    callback(null, stdout.replace(/^\s+|\s+$/g, ''));
  });
};


exports.task_predeploy = function(stack, baton, args, callback) {
    var opts = {cwd: stack.stackConfig.project_dir, env: process.env};
    misc.taskSpawn(baton, args, ['fab', 'pre_update:' + args.revision], opts, callback);
};

exports.task_update = function(stack, baton, args, callback) {
    var opts = {cwd: stack.stackConfig.project_dir, env: process.env};
    misc.taskSpawn(baton, args, ['fab', 'update'], opts, callback);
};

exports.task_deploy = function(stack, baton, args, callback) {
    var opts = {cwd: stack.stackConfig.project_dir, env: process.env};
    misc.taskSpawn(baton, args, ['fab', 'deploy'], opts, callback);
};

exports.targets = {
  'deploy': [
    'task_predeploy',
    'task_update',
    'task_deploy'
  ]
};
