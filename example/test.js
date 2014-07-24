/**
 * Created by ec on 14-7-25.
 */
Log = require("log4slow")
Log.info('hello');
Log.error(new Error('hello'));
Log.warn({a: 1,b: 2});
Log.debug([1, 2, 3, 4]);
Log.info([1, 2, 3, 4]);