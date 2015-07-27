// @file watch.js
var gulp = require('gulp');
var watch = require('gulp-watch');
var browserSync = require('browser-sync');
var config = require('../config').watch;

gulp.task('watch', ['server'], function() {
    // js
    gulp.watch(config.js, ['webpack', browserSync.reload]);

    // styl
    gulp.watch(config.styl, ['stylus', browserSync.reload]);

    // jade
    gulp.watch(config.jade, ['jade', browserSync.reload]);

    // images
    gulp.watch(config.imagemin, ['imagemin', browserSync.reload]);
});