
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
  res.sendFile 'login.html', SEND_FILE_OPTIONS

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
              link: "/v/glossary/edit/#{definition.id}/#{definition.slug}" 
            posts: for post in posts
              name: post.title
              link: "/v/blog/edit/#{post.id}/#{post.slug}" 
          res.send render('panel', viewData)

AdminRouter.post '/login', (req, res) ->
  Models.User.findOne {email: req.body.email}, (err, user) ->
    console.log("err", err)
    console.log("user", user)
    return res.send(null) if err or user is null
    user.verifyPassword req.body.password, (err, valid) ->
      return res.send(null) if err or not valid
      req.session.userId = user.id
      res.json
        url: "/v/admin/panel"



AdminRouter.on 'mount', (parent) =>
  console.log 'mounted admin routes'


module.exports = AdminRouter
