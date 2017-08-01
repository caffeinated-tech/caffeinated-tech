
VIEW_DIR = './public/views/admin/'

SEND_FILE_OPTIONS = 
  root: VIEW_DIR
  dotfiles: 'deny'
  headers: 
    'x-sent': true

render = (templateFile, data = {}) ->
  path = VIEW_DIR + templateFile + '.ejs'
  template = fs.readFileSync path, 'utf8'
  EJS.render(template, data)

AdminRouter = express()

AdminRouter.get '/', (req,res) ->
  html = fs.readFileSync VIEW_DIR+'login.html'
  SendHTML(req, res, html)


AdminRouter.get '/logout', (req,res) ->
  delete req.session.userId
  res.redirect '/'

AdminRouter.get '/panel', Middleware.auth, (req,res) ->
  Models.Definition.find().sort(createdAt: -1).exec()
    .then (definitions) ->
      Models.Post.find().sort(createdAt: -1).exec()
        .then (posts) ->
          viewData =
            definitions: for definition in definitions
              name: definition.title
              link: "/glossary/edit/#{definition.id}/#{definition.slug}" 
            posts: for post in posts
              name: post.title
              link: "/blog/edit/#{post.id}/#{post.slug}" 
          html = render('panel', viewData)
          SendHTML(req, res, html)

AdminRouter.post '/login', (req, res) ->
  Models.User.findOne {email: req.body.email}, (err, user) ->
    return res.send(null) if err or user is null
    user.verifyPassword req.body.password, (err, valid) ->
      return res.send(null) if err or not valid
      req.session.userId = user.id
      res.json
        url: "/admin/panel"


AdminRouter.on 'mount', (parent) => null

module.exports = AdminRouter
