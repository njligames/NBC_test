var fs = require('fs');
var readline = require('readline');
var request = require('request');
module.exports = {
    getAppName: function (packagetype, environment, territory, versionStamp) {
        let filename = "coreSDK-unitTests";
        return filename;
    },

    ////////////////////////
    /// TEST RANGE UTILS ///
    ////////////////////////

    /**
     * Converts range string into range block(s)
     * e.g:
     * "25-50"          >> ["25-50"]
     * "25-50|75-100"   >> ["25-50", "75-100"]
     *
     * @param {String} [str = ''] - range string
     * @returns {Array|null} - range block(s)
     */
    convertRangeStrToBlocks: function (str = '') {
        return str.match(/\d{1,2}?-\d{1,3}/g);
    },

    /**
     * Converts range block(s) into array and removes invalid range(s)
     * e.g:
     * ["25-50"]                    >> [["25", "50"]]
     * ["25-50", "75-100"]          >> [["25", "50"], ["75", "100"]]
     * ["25-50", "75-50", "75-100"] >> [["25", "50"], ["75", "100"]]
     *
     * @param {Array} [range = []] - range block(s)
     * @returns {Array} - valid ranges
     */
    getValidRanges: function (range = []) {
        return range.map(item => item.match(/(\d*?\d+)/g))
            // remove invalid ranges
            .filter(item => parseInt(item[0]) < parseInt(item[1]));
    },

    /**
     * Populates file(s) in given range(s)
     * e.g:
     * ['path/name.ext']
     *
     * @param {Array} [fileList = []] - files to be filtered
     * @param {Array} [range = []] - filtering range(s)
     * @returns {Array} - files in given range
     */
    getFilesInRange: function (fileList = [], range = []) {
        return range.reduce((filteredFiles, rangeArr) => {
            // replace percentage value with index
            rangeArr = rangeArr.map((item, index) => {
                if (index === 0) {
                    // start index
                    return Math.ceil(fileList.length * item / 100);
                } else {
                    // finish index
                    return Math.min(Math.ceil(fileList.length * item / 100), fileList.length) - 1;
                }
            });

            // files in range
            let files = fileList.filter((item, index) => index >= rangeArr[0] && index <= rangeArr[1])
            return filteredFiles.concat(files);
        }, []);
    },

    /**
     * Converts range(s) into formatted string
     * e.g:
     * X% to XX% (XXX files)
     * X% to XX% | X% to XX% (XXX files)
     *
     * @param {Array} [range = []] - range(s)
     * @returns {String} - formatted string
     */
    getFormattedRangeStr: function (range = []) {
        return range.reduce((copy, rangeArr, index) => {
            return copy += `${rangeArr[0]}% to ${rangeArr[1]}% ${index < range.length - 1 ? '| ' : ''}`
        }, '');
    },

    /**
     * Deploys app to roku box
     *
     * @param {String} [filePath] - the file to upload
     * @returns {String} - formatted string
     */
    deployRokuApp(filePath) {
        return new Promise((resolve, reject) => {

            const ROKU_DEV_PORT = process.env.ROKU_DEV_PORT || 80
            const ROKU_DEV_TARGET = process.env.ROKU_DEV_TARGET
            const ROKU_DEV_PASSWORD = process.env.ROKU_DEV_PASSWORD || "rokudev"

            let fileStat = fs.statSync(filePath);
            let fileStream = fs.createReadStream(filePath);
            let totalUploadedBytes = 0;
            // progress
            fileStream.on("data", function (data) {
                readline.clearLine(process.stdout);
                readline.cursorTo(process.stdout, 0);
                totalUploadedBytes += data.length;
                const uploadBarsLength = 25;
                const uploadPercentage = totalUploadedBytes / fileStat.size;
                const uploadParts = Math.floor(uploadPercentage * uploadBarsLength);
                process.stdout.write("#".repeat(uploadParts) + " ".repeat(uploadBarsLength - uploadParts) + " " + Math.floor(uploadPercentage * 100) + "%");
            });
            // request
            request({
                url: `http://${ROKU_DEV_TARGET}:${ROKU_DEV_PORT}/plugin_install`,
                method: "POST",
                auth: {
                    user: "rokudev",
                    pass: `${ROKU_DEV_PASSWORD}`,
                    sendImmediately: false
                },
                formData: {
                    mysubmit: "Install",
                    archive: fileStream,
                    passwd: ""
                }
            }, (error, response) => {
                if (response && response.statusCode === 200) {
                    console.log("\nUploaded!")
                    resolve();
                } else if (response && response.statusCode) {
                    console.log("\n[ERROR]: deploy process exited with status code " + response.statusCode);
                    console.log(response.statusMessage);
                    reject(response.statusMessage);
                } else if (error && error.code) {
                    console.log("\n[ERROR]: deploy process exited with error code " + error.code);
                    console.log(error.message);
                    reject(error.message);
                } else {
                    console.log("\n[ERROR]: deploy process exited unexpectedly!");
                    reject("Unexpected error");
                }
            });
        });
    }
};
