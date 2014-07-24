// Generated by CoffeeScript 1.7.1
(function() {
  var Log2File, createDir, cwd, formatName, getDirsArr, getFileName, output2file, _config, _fs, _mkdirp, _moment, _path;

  _config = require('./config.json');

  _mkdirp = require('mkdirp');

  _moment = require('moment');

  _path = require('path');

  _fs = require('fs');

  Log2File = {};

  Log2File.init = function(config) {
    return _config = config;
  };

  cwd = process.cwd();

  formatName = function(str, type) {
    str = str.toString();
    if (str.indexOf('$') === 0) {
      return _moment().format(str.replace('$', ''));
    }
    if (str.indexOf(':') === 0) {
      return type;
    }
    return str;
  };

  getDirsArr = function(type) {
    var d, dirs, _i, _len, _ref;
    dirs = _config.dirRoot && typeof _config.dirRoot === 'string' ? [_config.dirRoot] : [cwd];
    if (!_config.dirs || !_config.dirs.length) {
      return dirs.push(_config.default_dir);
    }
    if (typeof _config.dirs === 'string') {
      dirs.push(_config.dirs);
      return dirs;
    }
    _ref = _config.dirs;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      d = _ref[_i];
      dirs.push(formatName(d, type));
    }
    return dirs;
  };

  getFileName = function(type) {
    type = _config.levelfile && _config.levelfile[type] ? "-" + type : '';
    return "" + (formatName(_config.filename)) + type;
  };

  createDir = function(type) {
    var dirName;
    dirName = _path.join.apply(this, getDirsArr(type));
    _mkdirp.sync(dirName);
    return dirName;
  };

  output2file = function(content, type) {
    var filename;
    filename = _path.join(createDir(type), getFileName(type));
    return _fs.appendFile(filename, "" + content + "\n", function(err) {
      if (err) {
        return console.error(err);
      }
    });
  };

  module.exports = output2file;

}).call(this);