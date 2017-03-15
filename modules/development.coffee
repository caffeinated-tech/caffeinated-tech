DevelopmentModule =
  requestLoggingMiddleware: (req, res, next) ->
    console.log "-- #{Date.now()} -- #{req.method} -- #{req.url}"
    next()

module.exports  = DevelopmentModule