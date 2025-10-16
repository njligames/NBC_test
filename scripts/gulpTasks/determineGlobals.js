var fs = require("fs");

module.exports = function (gulp, plugins) {
    return (cb) => {
        let getArg = function (shortForm, longForm, defaultValue, envValue, transform) {
            let value = plugins.yargs.argv[longForm];
            if (value === undefined)
                value = plugins.yargs.argv[shortForm];
            if (value === undefined)
                value = envValue
            if (value === undefined)
                return defaultValue;
            if (transform)
                return transform(value);
            return value;
        }

        global.args = {
            debug: getArg('d', 'debug', false, process.env.NOWTV_DEBUG, function (arg) { return typeof (arg) == 'boolean' && arg ? 'DEBUG' : arg.toUpperCase(); }),
            appName: getArg('m', 'appname', global.defaultAppName),
            skipRedButton: !getArg('r', 'red-button', false),
            testsFilter: getArg('f', 'tests-filter', '', process.env.TESTS_FILTER),
            configServer: getArg('c', 'config-server', 'remote', process.env.NOWTV_CONFIG, function (arg) { return arg.toLowerCase(); }),
            autoRunWithoutSocket: getArg('w', 'auto-run-without-socket', false),
            numberOfTestAttempts: getArg('n', 'number-of-test-attempts', 1),
            testRequestRetries: getArg('s', 'test-request-retries', 3),
            // Informs Rooibos to wait create a socket and wait on a connection before running tests - CI
            rooibosPort: getArg('p', 'rooibos-port', null, process.env.ROOIBOS_PORT),
        }
        global.packageName = "cvsdk-refApp";
        global.projectDirectory = process.cwd();
        global.tasksDirectory = __dirname;
        global.settings = require(global.projectDirectory + '/scripts/build-settings.json');
        global.dependencies = global.settings.dependencies;
        global.testDependencies = global.settings.testDependencies;
        // this is populated in bundle dependent on build params
        global.zipFileName = ''

        cb()
    };
};
