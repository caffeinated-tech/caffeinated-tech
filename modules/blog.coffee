bodyParser = require('body-parser')
express = require('express')
User = require './user'

authenticated = (req, res, next) ->
  console.log 'is authenticated?'
  return res.send(null) unless req.session.userId?
  User.findOne
    _id: req.session.userId
  , (err, user) ->
    return res.send(null) if err or user is null
    next()

compileBlurb = (data) ->
  console.log '\n\ndata', data
  
  """
    <div class="section">
      <a href="v/blog/#{data.id}/#{data.slug}">
        <h3 class="blog">
          #{data.title}
        </h3>
      </a>
      <p>
        #{data.blurb}
      </p>
    </div>
  """

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
      posts = (compileBlurb(post) for post in posts).join("\n")
      top = fs.readFileSync('./public/views/blog.html')
      res.send """
        #{top}
        #{posts}
        <div class="row bottom">
          <div class="twelve columns">
            <a class="button button-primary" id="load-more-posts">View more</a>
          </div>
        </div>
      """

BlogModule.router.get '/more', (req,res) ->
  posts = BlogModule.Post.find()
    .sort(createdAt: -1)
    .limit(3)
    .skip(parseInt(req.query.count))  
    .exec (err, posts) ->
      console.log err
      console.log posts
      posts = (compileBlurb(post) for post in posts).join("\n")
      res.send posts

BlogModule.router.get '/new', authenticated, (req, res) ->
  res.sendFile './new_post.html', SEND_FILE_OPTIONS

BlogModule.router.post '/new', (req, res) ->
  console.log 'post/new'
  # console.log req
  console.log req
  req.body.slug = req.body.title.replace(/\s+/g, '-').toLowerCase()
  new BlogModule.Post(req.body).save (err, post) ->
    if err
      res.send err
    else
      console.log 'saved post, returing url:', "/v/blog/post/#{post.id}/#{post.slug}"
      res.json
        url: "/v/blog/post/#{post.id}/#{post.slug}"

BlogModule.router.get '/:id/:slug', (req, res) ->
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
