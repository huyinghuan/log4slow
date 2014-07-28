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

   /*
   * Where is log file ?   Array  or Bealean .  it's effective only the log2file be allow
   * log file be save to [app-root|absolute path]/logs  if dirs is false
   * dirs access a Array,  for example like this: ['a'， 'd' ] 
   * so the file will be save to    [app-root|absolute path]/a/d   if the 'dirRoot' is false
   * it will be format to time if  begin with '$'.
   *    the format rule please the http://momentjs.com/docs
   * it will be format log type if begin with ':'
   * the following option will be format :  [app-root|absolute path]/logs/2014/07/[error|warn|debug|info]
   */
   "dirs": ["logs", "$YYYY", "$MM", "：type"], 

   /*
   * what is name the file ?  String   default: $YYYMMDD
   * it will be format to time if begin with '$'
   * the following option will be format 20140725
   */
   "filename":"$YYYYMMDD",  //默认值 $YYYMMDD

   /*
   * Do separately save log file accord log type ?  Boolean or Object . default: false
   * if error is true:
   *    the log file will be   [app-root|absolute path]/[dirs]/error
   */
   "levelfile": {
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






