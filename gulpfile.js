var gulp = require('gulp');
var gulpLoadPlugins = require('gulp-load-plugins');
var path = require('path');
var requireDir = require('requiredir');
var config = require('dotenv').config;

config(path.join(__dirname, '.env'));

global.defaultAppName = 'core-video-sdk-roku';

// TEMPORY UNTIL EXEX/SHELL ISSUE IS RESOLVED
requireDir(__dirname + '/scripts/gulpTasks');

var pluginOpts = {
    config: path.join(__dirname, 'package.json'),
    replaceString: /^gulp(-|\.)/,
    scope: ['devDependencies'],
    pattern: ['*', "!rooibos"],
    lazy: false
};
var plugins = gulpLoadPlugins(pluginOpts);

// HELPER FUNCTION TO GET TASKS
function getTask(task) {
    return require('./scripts/gulpTasks/' + task)(gulp, plugins);
}

gulp.task('cleantask', getTask('clean'));
gulp.task('determineGlobals', getTask('determineGlobals'));
gulp.task('prepareMainFile', getTask('prepareMainFile'));
gulp.task('log', getTask('log'));
gulp.task('buildTask', getTask('build'))
gulp.task('buildTestsTask', getTask('buildTests'))
gulp.task('copyRooibos', getTask('copyRooibos'));
gulp.task('prepareRooibos', getTask('prepareRooibos'));
gulp.task('copyTests', getTask('copyTests'));

gulp.task('addLibs', getTask('addLibs'));
gulp.task('bundle', getTask('bundle'));
gulp.task('deploy', getTask('deploy'));
gulp.task('parseTestResults', getTask('parseTestResults'));

// GULP DEFINITIONS
var cleanTask = gulp.series("cleantask")
var bundle = gulp.series("cleantask", "determineGlobals", "log", "buildTask", "bundle")
var test = gulp.series("cleantask", "determineGlobals", "log", "buildTestsTask", "copyTests", "prepareMainFile", "copyRooibos", "prepareRooibos", "bundle")

// EXPORTS
module.exports = {
    default: bundle,
    clean: cleanTask,
    test: test
}
