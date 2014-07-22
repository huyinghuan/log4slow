_colors = require 'colors'
_config = require './config.json'
_moment = require 'moment'

_colors.setTheme
  info: 'green'
  help: 'cyan'
  warn: 'yellow'
  debug: 'blue'
  error: 'red'

#是否支持错误堆栈信息
isSupport = (()->
  err = new Error()
  return console.log "Node版本不支持slow4js / The version of node  do not support slow4js".warn if not err.stack
  return true
)()

# 通过error的堆栈信息获取产生日志的文件和代码行数
getFileAndLine = ()->
  return '' if not isSupport
  stack = new Error().stack
  #console.log , __dirname, process.cwd()
  info = stack.split('\n')[3]
  cwd = process.cwd()
  return '' if not info
  reg = new RegExp("#{cwd}([^:])+:\\d", "g")
  return fileInfo.replace cwd, '' if fileInfo = info.match(reg)[0]
  return ''

setConfig = (custom)->
  return _config if not custom
  _config[property] = custom[property] for property of custom
  return _config


format = (lineInfo, content, type)->
  loginfo = []
  loginfo.push _moment().format(_config.timestamp.format) if _config.timestamp
  loginfo.push lineInfo if _config.lineInfo
  loginfo.push "[#{type.toUpperCase()}]" if _config.levelShow
  loginfo.push content
  loginfo.join ' '

output2Console = (content, type)->
  console.log content[type] if _config.log2console and _config.log2console[type]

Log = {}

factory = (type)->
  (content)->
    lineinfo =  getFileAndLine()
    return if not content
    content = format(lineinfo, content, type)
    output2Console(content, type)

Log.warn = factory 'warn'
Log.error = factory 'error'
Log.info = factory 'info'
Log.debug = factory 'debug'

module.exports = Log