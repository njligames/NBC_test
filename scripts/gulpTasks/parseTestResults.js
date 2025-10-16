var net = require('net');
var fs = require('fs');

module.exports = function (gulp, plugins) {

    return (cb) => {

        const ROKU_DEV_TARGET = process.env.ROKU_DEV_TARGET

        const socket = net.Socket();


        // Race condition fudge
        getResults()
            .then(parseResults)
            .then(saveResults)
            .then((results) => {
                if (!results.success) {
                    console.log(`\n ${results.failedTests} Tests failed!  \n`)
                    cb()
                } else {
                    console.log(`\n ${results.passedTests} tests passed! \n`)
                    cb()
                }
            })
            .catch((err) => {
                console.log(`\n Error: ${err} \n`)
                cb(err)
            })

        function getResults() {
            return new Promise((fulfil, reject) => {
                let dataStr = "";

                socket.setEncoding("utf8");
                socket.setKeepAlive(false);
                socket.setTimeout(15000, () => {
                    socket.end();
                });

                socket.connect(global.args.rooibosPort, ROKU_DEV_TARGET);

                socket.on('connect', () => {
                    console.log(`\n Connected to ${ROKU_DEV_TARGET} \n`);
                });

                socket.on('data', (data) => {
                    dataStr = dataStr + data
                });

                socket.on('error', (err) => {
                    reject(`Unable to get response from box ${ROKU_DEV_TARGET}: ${err}`);
                });

                socket.on('end', () => {
                    console.log("Closing Socket!");
                    fulfil(dataStr);
                    console.log(`\n Disconnected from ${ROKU_DEV_TARGET} \n `);
                });
            });
        }

        function parseResults(resultStream) {

            return new Promise((fulfil, reject) => {

                parsed = JSON.parse(resultStream);

                let dataObj = {}
                dataObj.success = parsed.success
                dataObj.failedTests = parsed.failedtests;
                dataObj.failedTestsNames = parsed.failedtestsnames;
                dataObj.failedFiles = parsed.failedfiles;
                dataObj.failureMessages = parsed.failuremessages;
                dataObj.totalTests = parsed.testcount;
                dataObj.passedTests = dataObj.totalTests - dataObj.failedTests

                let xml = `<testsuites> \n <testsuite name="Rooibos" tests="${dataObj.totalTests}" failures="${dataObj.failedTests}" skipped="0">\n`

                for (var i = 0; i < dataObj.passedTests; i++) {
                    xml = xml + `<testcase name="Passed Test ${i}" classname="Tests"/> \n`
                }

                for (var j = 0; j < dataObj.failedTests; j++) {

                    let testName = dataObj.failedTestsNames[j]
                    let testMsg = dataObj.failureMessages[j]
                    let testFile = dataObj.failedFiles[j]

                    xml = xml + `<testcase name="${testName.trim()}" classname="${testFile.trim()}-FAIL"> \n <failure message="${testMsg}"/> \n </testcase> \n`
                }

                xml = xml + "</testsuite> \n </testsuites>"

                const empty = dataObj.totalTests == 0 ? true : false

                let result = {}
                result.xml = xml
                result.success = dataObj.success
                result.failedTests = dataObj.failedTests
                result.passedTests = dataObj.passedTests
                result.empty = empty

                fulfil(result);
            })
        }

        function saveResults(results) {
            return new Promise((fulfil, reject) => {
                if (results.empty == false) {
                    const testResultsLoc = process.env.TEST_RESULTS_LOC || ("./" + global.settings.unitTests.dir + "/results/")
                    if (!fs.existsSync(testResultsLoc)) {
                        fs.mkdirSync(testResultsLoc);
                    }

                    fs.writeFile(testResultsLoc + "test-results.xml", results.xml, (err) => {
                        if (err) { reject(err); }
                        console.log("\n Results saved to " + testResultsLoc + "test-results.xml \n ");
                    });
                }
                fulfil(results)
            });
        };
    };
};
