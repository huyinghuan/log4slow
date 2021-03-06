log4slow
========


日志记录. 记录包括,产生日志的文件名, 代码的行数等. 支持配置输出log文件  或控制台输出. 支持日志文件分类配置.分时间配置

## 快速开始

### 安装

```
npm install log4slow
```

### 使用
```coffeescript
Log = require('log4slow')

Log.info('hello')
Log.error(new Error('hello'))
Log.warn({a: 1, b: 2})
Log.info([1, 2, 3, 4])
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
  
  //是否显示输出日志的文件信息和代码行数。所有消息类型都显示 设置为true即可。（lineInfo: true）
  //由于该项资源开销比较大，请酌情开启（开发开启，生产关闭）。或者仅开启部分消息类型的记录,如下默认值
  "lineInfo": {
    "error": true,
    "debug": true, //由于一般生产环境不会记录debug类型到文件或者控制，所以这里可以设置为true
  }, 
  //设置日志是否保持到日志，已经保存日志的类型。
  //例如 保持所有信息设置log2file:true, 仅要保持error信息，只需设置log2file:{error:true}即可。
  //若不需要记录日志到文件使 log2file: false 即可
  "log2file":{  //默认值 false 不记录到文件。如需记录到文件请进行相关设置
      "debug": false,
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
   }
}
```

### Others Methos

#### init
  需要进行特殊配置时，可以使用Log.init(options) 进行覆盖设置
  options： JSON object
    具体字段请参考 上面的config部分

#### info, warn, error, debug
 参数类型可以为JSON object对象， 常量， Error 对象

### Test

```shell
  npm test
```

### Default Config

```
{
  "log2console": true, #打印到控制台
  "timestamp": "YYYY-MM-DD HH:mm:ss", #时间格式化
  "levelShow": true,  #显示消息等级
  "lineInfo": { #显示文件名称和代码行数
    "error": true,
    "debug": true
  },   
  "log2file": true,   #进行文件记录
  "dirRoot": false,   #根目录为应用更目录
  "dirs": false,  #使用默认文件夹
  "default_dir": "logs", #默认文件夹名称
  "filename": "$YYYYMMDD", #文件名格式化为20130723
  "levelfile": false  #不进行类别区分文件夹
}
```

### 特别提醒

显示文件名称和代码行数 它的开销是很大的。如果要用于生产环境，请关闭文件名和line number的显示
即"lineInfo": false. 或者仅设置error时 显示。 即 lineInfo: {error: true}
