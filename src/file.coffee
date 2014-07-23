_config = require './config.json'
_mkdirp = require 'mkdirp'
_moment = require 'moment'
_path = require 'path'
Log2File = {}

Log2File.init = (config)->
  _config = config

#如果日志保存文件夹不存在则使用默认logs文件夹
dirname = "logs"
cwd = process.cwd()

getDirName = ()->
  #是否配置绝对路径
  dirs = if _config.dirRoot and typeof _config.dirRoot is 'string' then [_config.dirRoot] else [cwd]
  return dirs if not _config.dirs or not _config.dirs.length

  if typeof _config.dirs is 'string'
    dirs.push _config.dirs
    return dirs

  for d in _config.dirs
    if d.indexOf('$') isnt 0
      dirs.push d
      continue
    dirs.push _moment().format d.replace('$', '')

  return dirs


#创建文件夹
createDir = ()->
  dirName = _path.join.apply @, getDirName()
  _mkdirp.sync dirName


#module.exports = createDir: createDir