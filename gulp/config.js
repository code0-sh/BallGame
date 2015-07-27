// @file config.js
var path = require('path');
var dest = './build';
var src = './src';
var relativeSrcPath = path.relative('.', src);
var BowerWebpackPlugin = require('bower-webpack-plugin');

module.exports = {
    dest: dest,

    js: {
        src: src + '/js/**',
        dest: dest + '/js',
        uglify: false
    },

    jade: {
        src: src + '/jade/**.jade',
        dest: dest + '/',
    },

    imagemin: {
        src: src + '/images/*.+(jpg|jpeg|png|gif|svg)',
        dest: dest + '/images',
        options: {optimizationLevel: 7}
    },

    webpack: {
        entry: src + '/js/app.js',
        output: {
            filename: 'bundle.js'
        },
        resolve: {
            extensions: ['', '.js']
        },
        module: { // ここを追記
            loaders: [{
                test: /\.js$/,
                exclude: /node_modules/,
                loaders: ['babel-loader?experimental&optional=selfContained', 'react-jsx-anywhere/webpack'] // パラメータ渡す
            }]
        },
        plugins: [
          new BowerWebpackPlugin({
            modulesDirectories: ["bower_components"],
            manifestFiles:      "bower.json",
            includes:           /.*/,
            excludes:           [],
            searchResolveModulesDirectories: true
          })
        ]
    },

    stylus: {
        src: [ // もし外部のcssフレームワーク使うなら配列の先頭で読み込むと良い
            src + '/styl/**/!(_)*' // ファイル名の先頭がアンスコはビルド対象外にする
        ],
        dest: dest + '/css/',
        output: 'app.css', // 出力ファイル名
        autoprefixer: {
            browsers: ['last 2 versions']
        },
        minify: false
    },

    watch: {
        js: relativeSrcPath + '/js/**',
        styl: relativeSrcPath + '/styl/**',
        jade: relativeSrcPath + '/jade/**',
        imagemin: relativeSrcPath + '/images/**'
    }
}