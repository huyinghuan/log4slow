log4slow
========

日志记录. 记录包括,产生日志的文件名, 代码的行数等. 支持配置输出.html, .log文件  或控制台输出. 支持日志文件分类配置.分时间配置,分大小配置.

### 快速开始

安装
```
npm install log4slow
```

使用
```coffeescript
log =   require 'log4slow'

log.info 'hello'
log.error 'hello'
log.warn 'hello'
log.info 'hello'
```
config
```js
{
  //是否在控制台输出.如果不需要在控制台输出则设置 log2console:false
  //如果只想显示特定类型的消息在控制台,设置为true即可
  //消息类型分别 debug, info, warn, error,需要什么就设置true
  "log2console": {
     "debug": false,
     "info": true,
     "warn": true,
     "error": true
  }
  //是否显示时间戳. 不显示使timestamp:false. 时间格式 请参考 http://momentjs.com/docs
  "timestamp": {
    "format": "YYYY-MM-DD "
  },
  //消息级别的标签是否显示
  "levelShow": true,
  //是否显示输出日志的文件信息和代码行数
  "lineInfo": true
}
```
