bodyParser = require('body-parser')
express = require('express')

compileBlurb = (data) ->
  console.log '\n\ndata', data
  
  """
    <div class="section">
      <a href="v/blog/post/#{data.id}/#{data.slug}">
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
      res.send """
        <h2 class="title">
          <a href="v/blog">
            Recent Blog Posts
          </a>
        </h2>
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

BlogModule.router.get '/post/new', (req, res) ->
  res.sendFile './new_post.html', SEND_FILE_OPTIONS

BlogModule.router.post '/post/new', (req, res) ->
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

BlogModule.router.get '/post/:id/:slug', (req, res) ->
  console.log 'looking for a post', req.params.id
  BlogModule.Post.findOne(_id: req.params.id).exec (err, post) ->
    if err
      res.send err
    else
      console.log 'post.body', post 
      html = """
        <div class="title">
          <h2>
            <a href="v/blog/post/#{post.id}/#{post.slug}">
              #{post.title}
            </a>
          </h2>
          <i>Posted: #{post.createdAt} by #{post.author}</i>
        </div>
      """ + post.body
      res.send html

BlogModule.router.on 'mount', (parent) =>
  @parent = parent


module.exports = BlogModule
