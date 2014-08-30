Log = require "../lib/log"
test = ->
  Log.debug [1, 2, 3, 4], {a: 1}
  Log.info 'hello'
  Log.error new Error('hello')
  Log.warn {a: 1, b: 2}, 2
  Log.info [1, 2, 3, 4], "test"
  Log.info [1], [2]
  Log.info 1
  Log.info true
  Log.info "test"
test()