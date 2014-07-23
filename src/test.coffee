Log = require "./log"
logfile = require "./file"
test = ->
  Log.error "this is error"
  Log.debug "this is success"
  Log.warn "this is warn"
  Log.info "this is info"

create = ->
  logfile.createDir()

create()