// @file stylus.js
var gulp = require('gulp');
var gulpif = require('gulp-if');
var plumber = require('gulp-plumber');
var notify = require('gulp-notify');
var stylus = require('gulp-stylus');
var concat = require('gulp-concat');
var autoprefixer = require('gulp-autoprefixer');
var minify = require('gulp-minify-css');
var using = require('gulp-using');
var config = require('../config').stylus;

gulp.task('stylus', function() {
    gulp.src(config.src)
        .pipe(plumber({errorHandler: notify.onError("<%= error.message %>")})) // エラー出ても止まらないようにする
        .pipe(using())
        .pipe(stylus()) // 実際コンパイルしてるのはここ
        .pipe(concat(config.output)) // 1つのファイルに固める
        .pipe(autoprefixer(config.autoprefixer)) // vendor-prefixつける
        .pipe(gulpif(config.minify, minify())) // 必要ならminifyする
        .pipe(gulp.dest(config.dest)); // 出力する
});
