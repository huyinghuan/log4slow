log4slow
========

日志记录. 记录包括,产生日志的文件名, 代码的行数等. 支持配置输出.html, .log文件  或控制台输出. 支持日志文件分类配置.分时间配置,分大小配置.

## 快速开始

### 安装

```
npm install log4slow
```

### 使用
```coffeescript
log =   require 'log4slow'

log.info 'hello'
log.error 'hello'
log.warn 'hello'
log.info 'hello'
```
### config 配置

> 默认情况下将读取应用根目录下的log4slow.json配置文件。注意是json文件格式，不能有注释等。
> 如果不存在则使用默认值。
> 如果存在，则覆盖默认值。 即只需要设置想要的字段即可，其他字段继续使用默认值

```js
{
  //是否在控制台输出.如果不需要在控制台输出则设置 log2console:false
  //如果只想显示特定类型的消息在控制台,设置相关类型为true即可
  //消息类型分别 debug, info, warn, error,需要什么就设置true 如 log2console:{error:true}
  //如果需要全部都显示，则设置 log2console:true
  "log2console": true; //默认值true。 全部显示

  //是否显示时间戳. 不显示使timestamp:false. 时间格式 请参考 http://momentjs.com/docs
  "timestamp": "YYYY-MM-DD HH:mm:ss",  //默认值 "YYYY-MM-DD HH:mm:ss"
  //消息级别的标签是否显示
  "levelShow": true,  //默认值 true
  //是否显示输出日志的文件信息和代码行数
  "lineInfo": true, //默认值 true
  //设置日志是否保持到日志，已经保存日志的类型。
  //例如 保持所有信息设置log2file:true, 仅要保持error信息，只需设置log2file:{error:true}即可。
  //若不需要记录日志到文件使 log2file: false 即可
  "log2file":{  //默认值 false 不记录到文件。如需记录到文件请进行相关设置
      "debug": true,
      "info": true,
      "warn": true,
      "error": true
   },
   //设置日志保持的绝对文件夹路径。如："c:\\a\" 或者 "/home/user/". 如果设置为false则默认为应用的根目录
   "dirRoot": false, //默认值 false
   //日志存放的文件夹.可以为数组，或者字符串。 如果不设置或者为false，则默认存放在应用logs目录下 或者 dirRoot目录下
   //如果字符串以 $ 符号开头，则表示将其进行日期格式化。格式化规则 请参考 http://momentjs.com/docs
   //如果前面带 : 则表示消息类型。
   //比如error类型的日志的保存到文件夹类似（由于上面dirRoot为false因此在应用根目录下）：
   // 应用根目录/logs/2014/07/error
   "dirs": ["logs", "$YYYY", "$MM", "：type"], //默认为false 即 保存到logs文件夹下面。 需要log2flie进行了相关设置才生效
   //日志的文件名。如果前面有$符号则格式化为日期 0712.log
   "filename":"$YYYYMMDD",  //默认值 $YYYMMDD
   //是否根据消息类型分文件显示. 把需要单独显示的类别设置为true即可。若不需要分开显示则设置levelfile为false
   //分开显示时,文件名为格式化后的名字加"-type" 这个功能和文件夹生成的规则(:)有点重复 建议同时只使用一个
   "levelfile": { //默认值为false
      "error": true,
      "info": true,
      "warn": true,
      "error": true
   },
   //设置每个日志文件的大小， 支持单位 KB, MB, GB. 默认单位是MB. 若不需要分割，则设置为false即可。
   //数字或数组.  数组时，下标为0的表示大小，下标为1的表示单位。
   "filesize": [2, "MB"] //默认值为false
}
```
