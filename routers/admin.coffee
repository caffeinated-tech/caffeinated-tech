
VIEW_DIR = './public/views/admin/'

render = (templateFile, data = {}) ->
  template = fs.readFileSync VIEW_DIR + templateFile
  doT.template(template)(data)

AdminRouter = express()

AdminRouter.get '/', (req,res) ->
  res.send render('login.html')

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
          res.send render('panel.html', viewData)

AdminRouter.post '/login', (req, res) ->
  Models.User.findOne {email: req.body.email}, (err, user) ->
    return res.send(null) if err
    user.verifyPassword req.body.password, (err, valid) ->
      return res.send(null) if err or not valid
      req.session.userId = user.id
      res.json
        url: "/v/admin/panel"



AdminRouter.on 'mount', (parent) =>
  console.log 'mounted admin routes'


module.exports = AdminRouter
