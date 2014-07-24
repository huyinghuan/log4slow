_colors = require 'colors'
_config = require './config.json'
_moment = require 'moment'
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
  console.log content[type] if _config.log2console and _config.log2console[type]

output2file = (content, type)->
  logfile content, type if _config.log2file and _config.log2file[type]

init = (custom)->
  return _config if not custom
  _config[property] = custom[property] for property of custom
  logfile.init _config
  return _config

Log = {}

factory = (type)->
  (content)->
    return if not content
    content = format(content, type)
    output2Console(content, type)
    output2file(content, type)

Log.warn = factory 'warn'
Log.error = factory 'error'
Log.info = factory 'info'
Log.debug = factory 'debug'
Log.init = init

module.exports = Log