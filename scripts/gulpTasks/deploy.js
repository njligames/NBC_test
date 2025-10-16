var fs = require('fs');
var readline = require('readline');
var request = require('request');

module.exports = function (gulp, plugins) {
    return (cb) => {
        // consts
        const ROKU_DEV_PORT = process.env.ROKU_DEV_PORT || 80
        const ROKU_DEV_TARGET = process.env.ROKU_DEV_TARGET
        const ROKU_DEV_PASSWORD = process.env.ROKU_DEV_PASSWORD || "rokudev"

        // setup
        let filePath = `./out/` + global.zipFileName;
        let fileStat = fs.statSync(filePath);
        let fileStream = fs.createReadStream(filePath);
        let totalUploadedBytes = 0;
        let options = {
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
        };

        // race condition delay
        setTimeout(() => {
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
            request(options, (error, response, body) => {
                console.log("");
                if (response && response.statusCode === 200) {
                    cb();
                } else if (response && response.statusCode) {
                    console.log("[ERROR]: deploy process exited with status code " + response.statusCode);
                    console.log(response.statusMessage);
                } else if (error && error.code) {
                    console.log("[ERROR]: deploy process exited with error code " + error.code);
                    console.log(error.message);
                } else {
                    console.log("[ERROR]: deploy process exited unexpectedly!");
                }
            });
        }, 100);
    };
};
