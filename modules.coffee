module.exports = (Server) ->
  DevelopmentModule = require('./modules/development')
  AdminModule = require('./modules/admin')
  HomeModule = require('./modules/home')
  BlogModule = require('./modules/blog')
  GlossaryModule = require('./modules/glossary')
  ContactModule = require('./modules/contact')
  CVModule = require('./modules/cv')


  Server.use DevelopmentModule.requestLoggingMiddleware
  
  Server.use '/v/*', (req,res,next) -> 
    # if the request is via ajax, then use the requested route handler.
    #   otherwise send the index page, which will then fetch the right page by 
    #  ajax
    if req.header('X-REQUESTED-WITH') is 'XMLHttpRequest'
      next()
    else
      console.log 'send index.html instead'
      res.sendFile './index.html', SEND_FILE_OPTIONS

  Server.use '/v/admin', AdminModule.router
  Server.use '/v/home', HomeModule.router
  Server.use '/v/blog', BlogModule.router
  Server.use '/v/glossary', GlossaryModule.router
  Server.use '/v/contact', ContactModule.router
  Server.use '/v/profile', CVModule.router