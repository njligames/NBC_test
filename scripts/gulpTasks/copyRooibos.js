var merge = require('merge-stream');

module.exports = function (gulp, plugins) {
    return () => {
        let merged = merge().add(gulp.src('./node_modules/rooibos/dist/rooibosDist.brs').pipe(gulp.dest('build/source/tests/rooibos')));
        return merged;
    };
};
