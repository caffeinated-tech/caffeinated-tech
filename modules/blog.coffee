bodyParser = require('body-parser')
express = require('express')


BlogModule = 
  parent: null
  router: express()

# BlogModule.router.use(bodyParser.json())

BlogModule.router.get '/', (req,res) ->
  posts = Models.Post.find()
    .sort(createdAt: -1)
    .limit(3)
    .exec (err, posts) ->
      posts = (post.blurbHTML() for post in posts).join("\n")
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
  posts = Models.Post.find()
    .sort(createdAt: -1)
    .limit(3)
    .skip(parseInt(req.query.count))  
    .exec (err, posts) ->
      posts = (post.blurbHTML() for post in posts).join("\n")
      res.send posts

BlogModule.router.get '/new', Middleware.auth, (req, res) ->
  res.sendFile './new_post.html', SEND_FILE_OPTIONS

BlogModule.router.post '/new', Middleware.auth, (req, res) ->
  req.body.slug = req.body.title.replace(/\s+/g, '-').toLowerCase()
  new Models.Post(req.body).save (err, post) ->
    if err
      res.send err
    else
      res.json
        url: "/v/blog/post/#{post.id}/#{post.slug}"

BlogModule.router.get '/:id/:slug', (req, res) ->
  Models.Post.findOne(_id: req.params.id).exec (err, post) ->
    if err
      res.send err
    else
      res.send post.body

BlogModule.router.on 'mount', (parent) =>
  @parent = parent


module.exports = BlogModule
