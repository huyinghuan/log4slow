Log = require "./log"
test = ->
    Log.info 'hello'
    Log.error new Error('hello')
    Log.warn {a: 1, b: 2}
    Log.debug [1, 2, 3, 4]
    Log.info [1, 2, 3, 4]
    Log.info 'hello', 'world'
    Log.info {a: 1, b: 2}, [12, 23, 34]
    Log.info {a: 1, b: 2}, [12, 23, 34], new Error('hello')
    Log.info {a: 1, b: 4}, "hello ?", 123
test()