_config = require './config.json'
_mkdirp = require 'mkdirp'
_moment = require 'moment'
_path = require 'path'
_fs = require 'fs'
Log2File = {}

Log2File.init = (config)->
  _config = config

cwd = process.cwd()

formatName = (str, type)->
  str = str.toString()
  return _moment().format str.replace('$', '') if str.indexOf('$') is 0
  return type if str.indexOf(':') is 0
  return str

getDirsArr = (type)->
  #是否配置绝对路径
  dirs = if _config.dirRoot and typeof _config.dirRoot is 'string' then [_config.dirRoot] else [cwd]
  #是否使用默认至
  return dirs.push _config.default_dir if not _config.dirs or not _config.dirs.length

  if typeof _config.dirs is 'string'
    dirs.push _config.dirs
    return dirs

  dirs.push formatName d, type for d in _config.dirs
  return dirs

getFileName = (type)->
  type = if _config.levelfile and _config.levelfile[type] then "-#{type}" else ''
  return "#{formatName(_config.filename)}#{type}"

#创建文件夹
createDir = (type)->
  dirName = _path.join.apply @, getDirsArr(type)
  _mkdirp.sync dirName
  return dirName

output2file = (content, type)->
  filename = _path.join(createDir(type), getFileName(type))
  _fs.appendFile filename, "#{content}\n", (err)->
    console.error err if err

module.exports = output2file