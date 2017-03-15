module.exports = (Server) ->
  DevelopmentModule = require('./modules/development')
  HomeModule = require('./modules/home')
  BlogModule = require('./modules/blog')
  
  Server.use DevelopmentModule.requestLoggingMiddleware
  Server.use '/home', HomeModule.router
  Server.use '/blog', BlogModule.router