
VIEW_DIR = './public/views/profile/'

SEND_FILE_OPTIONS = 
  root: VIEW_DIR
  dotfiles: 'deny'
  headers: 
    'x-sent': true

render = (templateFile, data = {}) ->
  path = VIEW_DIR + templateFile + '.ejs'
  template = fs.readFileSync path, 'utf8'
  EJS.render(template, data)

ProfileRouter = express()

ProfileRouter.get '/', (req,res) ->
  html = fs.readFileSync VIEW_DIR+'index.html'
  SendHTML(req, res, html)

module.exports = ProfileRouter
