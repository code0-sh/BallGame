// @file jade.js
var gulp = require('gulp');
var plumber = require('gulp-plumber');
var notify = require('gulp-notify');
var jade = require('gulp-jade');
var using = require('gulp-using');
var config = require('../config').jade;

gulp.task('jade', function () {
  gulp.src(config.src)
    .pipe(plumber({errorHandler: notify.onError("<%= error.message %>")})) // エラー出ても止まらないようにする
    .pipe(using())
    .pipe(jade())
    .pipe(gulp.dest(config.dest))
});