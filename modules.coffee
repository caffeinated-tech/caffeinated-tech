module.exports = (Server) ->
  DevelopmentModule = require('./modules/development')
  # AdminModule = require('./modules/admin')
  # HomeModule = require('./modules/home')
  # BlogModule = require('./modules/blog')
  # ContactModule = require('./modules/contact')
  # CVModule = require('./modules/cv')


  VIEW_DIR = './public/views/'

  render = (templateFile, data = {}) ->
    path = VIEW_DIR + templateFile + '.ejs'
    template = fs.readFileSync path, 'utf8'
    EJS.render(template, data)

  Server.use DevelopmentModule.requestLoggingMiddleware

  global.SendHTML = (req, res, contents) ->
    if req.header('X-REQUESTED-WITH') is 'XMLHttpRequest'
      res.send contents
    else
      console.log 'send in index.html instead', req.originalUrl.split('/')[2]
      urlComponents = req.originalUrl.split('/')
      console.log urlComponents
      html = render 'index', 
        section: urlComponents[1] || 'Web Development'
        title: (urlComponents[3] ||  'Blog').replace(/-/g, ' ')
        contents: contents 

      res.send html

  # Server.use '/v/*', (req,res,next) -> 
  #   # if the request is via ajax, then use the requested route handler.
  #   #   otherwise send the index page, which will then fetch the right page by 
  #   #  ajax
  #   if req.header('X-REQUESTED-WITH') is 'XMLHttpRequest'
  #     next()
  #   else
  #     console.log 'send index.html instead'
  #     res.sendFile './index.html', SEND_FILE_OPTIONS

  # Server.use '/v/admin', AdminModule.router
  # Server.use '/v/home', HomeModule.router
  # Server.use '/v/blog', BlogModule.router
  # Server.use '/v/contact', ContactModule.router
  # Server.use '/v/profile', CVModule.router