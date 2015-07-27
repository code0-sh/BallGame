// @file imagemin.js
var gulp = require('gulp');
var plumber = require('gulp-plumber');
var imagemin = require('gulp-imagemin');
var notify = require('gulp-notify');
var config = require('../config').imagemin;

gulp.task('imagemin', function () {
  gulp.src(config.src)
  	.pipe(imagemin(config.options))
    .pipe(plumber({errorHandler: notify.onError("<%= error.message %>")})) // エラー出ても止まらないようにする
    .pipe(gulp.dest(config.dest))
});