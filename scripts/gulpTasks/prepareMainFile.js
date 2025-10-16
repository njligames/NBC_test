var replace = require("gulp-replace");

module.exports = function (gulp, plugins) {
    return () => {
        let stream = gulp.src(['./source/main_tests.brs'])
            .pipe(replace("Main_Tests()", "Main()"))
            .pipe(gulp.dest('build/source'));

        return stream
    };
};
