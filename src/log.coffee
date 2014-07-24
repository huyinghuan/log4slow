_colors = require 'colors'
_config = require './config.json'
_moment = require 'moment'
_fs = require 'fs'
_path = require 'path'
logfile = require './file'

#控制台颜色配置
_colors.setTheme
  info: 'green'
  help: 'cyan'
  warn: 'yellow'
  debug: 'blue'
  error: 'red'

#是否支持错误堆栈信息
isSupport = (()->
  err = new Error()
  return console.log "The version of node  do not support slow4js".warn if not err.stack
  return true
)()

# 通过error的堆栈信息获取产生日志的文件和代码行数
getFileAndLine = ()->
  return '' if not isSupport
  stack = new Error().stack
  info = stack.split('\n')[4]
  cwd = process.cwd()
  return '' if not info
  reg = new RegExp("#{cwd}([^:])+:(\\d)+", "g")
  return fileInfo.replace cwd, '' if fileInfo = info.match(reg)[0]
  return ''

#合成日志内容
format = (content, type)->
  loginfo = []
  loginfo.push _moment().format(_config.timestamp) if _config.timestamp
  loginfo.push getFileAndLine() if _config.lineInfo
  loginfo.push "[#{type.toUpperCase()}]" if _config.levelShow
  loginfo.push content
  loginfo.join ' '

output2Console = (content, type)->
  return if not _config.log2console
  console.log content[type] if _config.log2console is true or _config.log2console[type]

output2file = (content, type)->
  return if not _config.log2file
  logfile.output content, type if _config.log2file is true or _config.log2file[type]

#生成各种类型的消息
factory = (type)->
  (content)->
    return if not content
    content = format(content, type)
    output2Console(content, type)
    output2file(content, type)

#浅继承 仅继承第一层属性
extend = (src, dist)->
  return src if not dist
  src[property] = dist[property] for property of dist
  return src

class Log
  constructor: ()->
    default_config = _path.join process.cwd(), 'log4slow.json'
    if _fs.existsSync(default_config) and _fs.statSync(default_config).isFile()
      _config = extend _config, require default_config
      logfile.init _config
  init: (options)->
    _config = extend(_config, options)
    logfile.init _config

  warn: factory 'warn'

  error: factory 'error'

  info: factory 'info'

  debug: factory 'debug'

module.exports = new Log()