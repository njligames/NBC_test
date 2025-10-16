var merge = require('merge-stream');

module.exports = function (gulp, plugins) {
    return () => {
        let merged = merge();
        global.dependencies.forEach(function (dep) {
            merged.add(gulp.src('./node_modules/' + dep + '/source/**/*.brs', { base: 'node_modules' }).pipe(gulp.dest('build/source')));
        });
        merged.add(gulp.src('./node_modules/roku-common_conviva-lib/source/utilities/ConvivaTask.xml', { base: 'node_modules' })
            .pipe(gulp.dest('build/components')));
        merged.add(gulp.src('./node_modules/roku-common_conviva-lib/source/utilities/ConvivaCoreLib.brs', { base: 'node_modules' })
            .pipe(gulp.dest('build/components')));
        merged.add(gulp.src('./node_modules/roku-common_conviva-lib/source/utilities/ConvivaTask.brs', { base: 'node_modules' })
            .pipe(gulp.dest('build/components')));
        merged.add(gulp.src('package.json').pipe(gulp.dest('build/')));
        return merged;
    };
};
