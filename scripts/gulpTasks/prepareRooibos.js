var glob = require('glob');
var rooibos = require('rooibos-cli');
var utils = require('./utilities');

module.exports = function (gulp, plugins) {
    return (callback) => {

        filesPattern = global.settings.unitTests.dir + global.settings.unitTests.sources + '.brs'

        // Define Rooibos Processor Config
        let testsFilePattern = [
            "!**/rooibosDist.brs",
            "!**/rooibosFunctionMap.brs",
            "!**/TestsScene.brs"
        ].concat([filesPattern]);

        let config = rooibos.createProcessorConfig({
            "projectPath": "./build",
            "testsFilePattern": testsFilePattern,
            "outputPath": "source/tests/rooibos",
            "port": global.args.rooibosPort
        });

        let processor = new rooibos.RooibosProcessor(config);
        processor.processFiles();

        callback();
    }
};
