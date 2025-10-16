var fs = require("fs-extra");
var merge = require('merge-stream');

module.exports = function (gulp, plugins) {
    return () => {
        let stream = merge();
        global.settings.sources.forEach(function (source) {
            if (source.paths !== undefined && source.paths.constructor === Array)
                stream.add(gulp.src(source.paths, source.options).pipe(gulp.dest(source.destination)));
            if (source.files !== undefined && source.files.constructor === Array) {
                source.files.forEach(function (file) {
                    if (fs.existsSync(file));
                    stream.add(gulp.src(file, source.options).pipe(gulp.dest(source.destination)));
                });
            }
        });
        return stream;
    };
};
