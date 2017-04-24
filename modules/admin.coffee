express = require('express')

VIEW_DIR = './public/views/admin/'

render = (templateFile, data = {}) ->
  template = fs.readFileSync VIEW_DIR + templateFile
  doT.template(template)(data)

AdminModule = 
  parent: null
  router: express()

AdminModule.router.get '/', (req,res) ->
  res.send render('login.html')

AdminModule.router.get '/logout', (req,res) ->
  delete req.session.userId
  res.redirect '/'

AdminModule.router.get '/panel', Middleware.auth, (req,res) ->
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
          console.log definitions.length, posts.length
          res.send render('panel.html', viewData)

AdminModule.router.post '/login', (req, res) ->
  Models.User.findOne {email: req.body.email}, (err, user) ->
    return res.send(null) if err
    user.verifyPassword req.body.password, (err, valid) ->
      return res.send(null) if err or not valid
      req.session.userId = user.id
      res.json
        url: "/v/admin/panel"



AdminModule.router.on 'mount', (parent) =>
  @parent = parent


module.exports = AdminModule
