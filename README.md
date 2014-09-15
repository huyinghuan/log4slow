log4slow
========
logger information to file

[![NPM](https://nodei.co/npm/log4slow.png?downloads=true&downloadRank=true&stars=true)](https://nodei.co/npm/log4slow/)

##API
1. Chinese: https://github.com/huyinghuan/log4slow/blob/master/README.zh_cn.md
2. English: https://github.com/huyinghuan/log4slow/blob/master/README.en_US.md

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
  
  // Log[type](arg1, arg2, ...)
  Log.info({a: 1}, [1, 23, 4], 'test')
  
  //and can accept  Object or Error
  Log.info({a: 1, b: 2})
  Log.warn([1, 23, 4, 5])
  Log.debug(new Error('test log'))
  
```

## test

```shell
  cd log4slow
  npm test
```


## example

```shell
 cd log4slow/example
```

## configure

In the default, read the configure ```appRoot/log4slow.json```, if it isn't exists, will use ```log4slow's default configure```

```js
{
  /*
  * Do output to console ?  Boolean or Object    
  * Default: true
  * if show all set 'log2console: true',  otherwise, set 'log2console: false'
  * if just need some of them ,set the type true. 
  * for example just output debug:   
  *     log2console: {debug: true}
  */
  "log2console": true; 

  /*
  * Do output timestamp ? Boolean or String.  
  * Default: "YYYY-MM-DD HH:mm:ss"
  * if show this, set date foramt string. for example: "YYYYMMDD".  
  * the format rule please see http://momentjs.com/docs
  * otherwish, set timestamp: false
  */
  "timestamp": "YYYY-MM-DD HH:mm:ss",

  /*
  * Do output log level ?   Boolean    
  * Default: true
  * if true, will output "[DEBUG]|[INFO]|[ERROR]|[WARN]" in console for log
  * if don't need this , set it be false
  */
  "levelShow": true,

  /*
  * Do output the file name and line number ?  Boolean or Object. 
  * Default: {error: true, debug: true}
  * if output all type, set "lineInfo": true . otherwise set  set "lineInfo": false
  * if just output for some log level,  set the level be true. 
  * e.g :   lineInfo:{"error": true, "debug": true}
  *
  * Note !!!!!
  *    Output the file name and line number  will consume a lot of system resourse . 
  * Suggestion:
  *    In the develop enviroment , you can set it as you want. 
  *    In the product enviroment, set lineInfo just for error level log.  
  *       for example: lineInfo: {"error": true}
  */
  "lineInfo": {
    "error": true,
    "debug": true,
  }, 

  /*
  * Do output to file ?   Boolean or Object.  
  * Default:  false
  * the rule like  log2cosole
  */
  "log2file":{
      "debug": false,
      "info": true,
      "warn": true,
      "error": true
   },

   /*
   * set the directory for log file.   directory path (absolute path) or  Boolean.   
   * Default: false
   * if false  the log file will be save in app root. 
   * or the path  like  "C:\\logs\\"    "/home/username/logs/"
   */
   "dirRoot": false,

   /*
   * Where is log file ?   Array  or Bealean .  
   * Default: false.
   * Note:  it's effective only the log2file be allow
   *
   * log file be save to [app-root|absolute path]/logs  if dirs is false
   * dirs access a Array,  for example like this: ['a'， 'd' ], 
   * so the file will be save to  [app-root|absolute path]/a/d
   *
   * it will be format to time if  begin with '$'.
   *    the format rule please the http://momentjs.com/docs
   *
   * it will be format log type if begin with ':'
   * the following option will be format :  
   *    [app-root|absolute path]/logs/2014/07/[error|warn|debug|info]
   */
   "dirs": ["logs", "$YYYY", "$MM", "：type"], 

   /*
   * what is name the file ?  String   
   * Default: $YYYMMDD
   * it will be format to time if begin with '$'
   * the following option will be format 20140725
   */
   "filename":"$YYYYMMDD",

   /*
   * Do separately save log file accord log type ?  Boolean or Object .
   * Default: false
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

```js
Log.init(configObject)
```

## History
v0.1.1
1. Support  log4slow.json replace with log4slow.js

v0.1.0
1. fixed a bug that throws error  when log4slow use in bin node_module

v0.0.9
1. update project struct
2. fixed a bug about issue #1





