_colors = require 'colors'
_config = require './configure'
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
  #reg = new RegExp("#{cwd}([^:])+:(\\d)+", "g")
  reg = new RegExp("\(.+\)", 'ig')
  result = info.match(reg)
  if result
    fileInfo = result[0]
    return fileInfo.replace cwd, ''
  #如果该组建用在一个bin形式的node_moudle中时，显示完整路径
  reg = new RegExp("\(.+\)")
  result = info.match(reg)
  return result[0] if result
  return ''

#根据不同数据类型 string, json object, error 获取格式良好的显示的信息
getContentFromDataType = (contents)->
  result = []
  for content, index in contents
    if(content instanceof Error)
      result.push content.stack
      continue

    if content instanceof Object or content instanceof Array
      result.push JSON.stringify content
      continue

    result.push "#{content}"

  result.join ', '

#合成日志内容
format = (content, type)->
  loginfo = []
  content = getContentFromDataType content
  loginfo.push _moment().format(_config.timestamp) if _config.timestamp
  loginfo.push getFileAndLine() if _config.lineInfo is true or _config.lineInfo[type]
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
    content = format(arguments, type)
    output2Console(content, type)
    output2file(content, type)

#浅继承 仅继承第一层属性
extend = (src, dist)->
  return src if not dist
  src[property] = dist[property] for property of dist
  return src

class Log
  constructor: ()->
    #获取自定义配置文件
    default_config = _path.join process.cwd(), 'log4slow.json'
    #如果自定义文件存在则覆盖默认配置设置
    if _fs.existsSync(default_config) and _fs.statSync(default_config).isFile()
      _config = extend _config, require default_config
    #初始化 日志文件输出设置
    logfile.init _config

  init: (options)->
    _config = extend(_config, options)
    logfile.init _config

  warn: factory 'warn'

  error: factory 'error'

  info: factory 'info'

  debug: factory 'debug'

module.exports = new Log()