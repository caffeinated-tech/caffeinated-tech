express = require('express')

authenticated = (req, res, next) ->
  return res.send(null) unless req.session.userId?
  AdminModule.User.findOne
    _id: req.session.userId
  , (err, user) ->
    return res.send(null) if err or user is null
    next()
    
AdminModule = 
  parent: null
  router: express()
  User: require('./user')

AdminModule.router.get '/', (req,res) ->
  console.log "req.session"
  console.log req.session
  res.sendFile './admin.html', SEND_FILE_OPTIONS

AdminModule.router.get '/logout', (req,res) ->
  delete req.session.userId
  res.redirect '/'

AdminModule.router.get '/panel', authenticated, (req,res) ->
  console.log "admin panel - we are authenticated"
  console.log "req.session"
  console.log req.session
  res.sendFile './admin_panel.html', SEND_FILE_OPTIONS

AdminModule.router.post '/login', (req, res) ->
  console.log "req.session"
  console.log req.session
  console.log "req.body"
  console.log req.body
  AdminModule.User.findOne {email: req.body.email}, (err, user) ->
    return res.send(null) if err
    user.verifyPassword req.body.password, (err, valid) ->
      console.log 'valid passowrd!'
      return res.send(null) if err or not valid
      req.session.userId = user.id
      console.log "\nset the id on the session\n"
      res.json
        url: "/v/admin/panel"



AdminModule.router.on 'mount', (parent) =>
  @parent = parent


module.exports = AdminModule
