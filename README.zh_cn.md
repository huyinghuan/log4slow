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

