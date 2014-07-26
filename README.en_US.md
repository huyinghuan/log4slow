## Install

```shell
  npm install log4slow
```

## Using

```javascript
  Log = require("log4slow")
  
  Log.info("hello, this is infomation")
  Log.warn("hello, this is warning")
  Log.error("hello, this is error")
  Log.debug("hello, this is debug")
  
  //and can accept  Object or Error
  Log.info({a: 1, b: 2})
  Log.warn([1, 23, 4, 5])
  Log.debug(new Error('test log'))
  
```

## test

```
  cd log4slow
  npm test
```


## example

```
 cd log4slow/example
```

## configure

In the default, read the configure ```appRoot/log4slow.json```, if it isn't exists, will use ```log4slow's default configure```

```
{
  /*
  * Do output to console ?  Boolean or Object     default: true
  * if show all set log2console: true,  otherwise, set log2console: false
  * if just need some of them ,set the type true. for example just output debug:   log2console: {debug: true}
  */
  "log2console": true; 

  /*
  * Do output timestamp ? Boolean or String.  default: "YYYY-MM-DD HH:mm:ss"
  *if show this, set date foramt string. for example: "YYYYMMDD".  the format rule please see http://momentjs.com/docs
  *otherwish, set timestamp: false
  */
  "timestamp": "YYYY-MM-DD HH:mm:ss",

  /*
  * Do output log level ?   Boolean    default: true
  * if true, will output "[DEBUG]" or "[INFO]" or "[ERROR]" or "[WARN]" in console for log
  * if don't need this , set it be false
  */
  "levelShow": true,

  /*
  * Do output the file name and line number ?  Boolean or Object.  default: {error: true, debug: true}
  * if output all type, set "lineInfo": true . otherwise set  set "lineInfo": false
  * if just output for some log level,  set the level be true. e.g :   lineInfo:{"error": true, "debug": true}
  *
  * Note !!!!!
  *    Output the file name and line number  will consume a lot of system resourse . 
  * Suggestion:
  *    In the develop enviroment , you can set it as you want. 
  *     In the product enviroment, set lineInfo just for error level log.  for example: lineInfo: {"error": true}
  */
  "lineInfo": {
    "error": true,
    "debug": true, //由于一般生产环境不会记录debug类型到文件或者控制，所以这里可以设置为true
  }, 

  /*
  *Do output to file ?   Boolean or Object.  default:  false
  *the rule like  log2cosole
  */
  "log2file":{
      "debug": false,
      "info": true,
      "warn": true,
      "error": true
   },

   /*
   *set the directory for log file.   directory path (absolute path) or  Boolean.    default: false
   * if false  the log file will be save in app root. 
   * or the path  like  "C:\\logs\\"    "/home/username/logs/"
   */
   "dirRoot": false,

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




## API

### warn, info, error, debug

Accept JSON Object, Error Object , and string,number ...


### init
Accept JSON Object as configure. will replace default configure's property

```
Log.init(configObject)
```






