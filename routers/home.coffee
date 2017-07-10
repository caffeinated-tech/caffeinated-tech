
VIEW_DIR = './public/views/home/'

SEND_FILE_OPTIONS = 
  root: VIEW_DIR
  dotfiles: 'deny'
  headers: 
    'x-sent': true

render = (templateFile, data = {}) ->
  path = VIEW_DIR + templateFile + '.ejs'
  template = fs.readFileSync path, 'utf8'
  EJS.render(template, data)

HomeRouter = express()

HomeRouter.get '/', (req,res) ->
  html = fs.readFileSync VIEW_DIR+'index.html'
  SendHTML(req, res, html)
  
module.exports = HomeRouter
