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
  "timestamp": "YYYY-MM-DD",
  //消息级别的标签是否显示
  "levelShow": true,
  //是否显示输出日志的文件信息和代码行数
  "lineInfo": true,
  //设置日志是否保持到日志，已经保存日志的类型。
  //例如 要保持error信息，只需设置error为true即可。若不需要记录日志到文件使 log2file: false 即可
  "log2file":{
      "debug": true,
      "info": true,
      "warn": true,
      "error": true
   },
   //设置日志保持的绝对文件夹路径。如："c:\\a\" 或者 "/home/user/". 如果设置为false则默认为应用的根目录
   "dirRoot": false
   //日志存放的文件夹.可以为数组，或者字符串。 如果不设置，则默认存放在应用根目录下 或者 dirRoot目录下
   //如果字符串以 $ 符号开头，则表示将其进行日期格式化。格式化规则 请参考 http://momentjs.com/docs
   //日志的保存到文件夹类似（由于上面dirRoot为false因此在应用根目录下）：
   // 应用根目录/logs/2014/07/hello
   "dirs": ["logs", "$YYYY", "$MM", "hello"],
   //日志的文件名。如果前面有$符号则格式化为日期 15-12.log
   "filename":"$DD-HH"
}
```
