module.exports = function (gulp, plugins) {
    return () => {
        const stream = plugins.del(['./build'])
        return stream
    };
};
