bodyParser = require('body-parser')
express = require('express')

BlogModule = 
  parent: null
  router: express()
  Post: require './post'

# BlogModule.router.use(bodyParser.json())

BlogModule.router.get '/', (req,res) ->
  posts = BlogModule.Post.find()
    .sort(createdAt: -1)
    .limit(3)
    .exec (err, posts) ->
      res.send (post.body for post in posts).join("\n")

BlogModule.router.get '/post/new', (req, res) ->
  res.sendFile './new_post.html', SEND_FILE_OPTIONS

BlogModule.router.post '/post/new', (req, res) ->
  console.log 'post/new'
  # console.log req
  console.log req.body
  new BlogModule.Post(req.body).save (err, post) ->
    if err
      res.send err
    else
      res.send post

BlogModule.router.get '/post/:id', (req, res) ->
  console.log 'looking for a post', req.params.id
  BlogModule.Post.findOne(_id: req.params.id).exec (err, post) ->
    if err
      res.send err
    else
      console.log 'post.body', post 
      res.send post.body

BlogModule.router.on 'mount', (parent) =>
  @parent = parent


module.exports = BlogModule
