express = require('express')
    
AdminModule = 
  parent: null
  router: express()

AdminModule.router.get '/', (req,res) ->
  res.sendFile './admin.html', SEND_FILE_OPTIONS

AdminModule.router.get '/logout', (req,res) ->
  delete req.session.userId
  res.redirect '/'

AdminModule.router.get '/panel', Middleware.auth, (req,res) ->
  res.sendFile './admin_panel.html', SEND_FILE_OPTIONS

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
