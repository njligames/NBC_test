var fs = require('fs')

module.exports = function (gulp, plugins) {
    return () => {

        var packageName = "challenge.zip"

        global.zipFileName = packageName
        const stream = gulp.src('./build/**/*', { base: './build' })
            .pipe(plugins.zip(packageName))
            .pipe(gulp.dest('./out'))

        return stream
    };
};
