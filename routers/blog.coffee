
VIEW_DIR = './public/views/blog/'
PER_PAGE = 3

SEND_FILE_OPTIONS = 
  root: VIEW_DIR
  dotfiles: 'deny'
  headers: 
    'x-sent': true

render = (templateFile, data = {}) ->
  path = VIEW_DIR + templateFile + '.ejs'
  template = fs.readFileSync path, 'utf8'
  EJS.render(template, data)

maxPosts = ->
  Models.Post
    .count()
    .exec()

loadPosts = (skip = 0) ->
  Models.Post.find()
    .sort(createdAt: -1)
    .limit(PER_PAGE)
    .skip(skip)
    .exec()

BlogRouter = express()

BlogRouter.get '/', (req,res) ->
  maxCount = 0
  maxPosts()
    .then (count) ->
      maxCount = count
      loadPosts()
    .then (posts) ->
      data = 
        posts: posts
        morePosts: maxCount > PER_PAGE
      html = render('index', data)
      SendHTML(req, res, html)

BlogRouter.get '/more', (req,res) ->
  skip = parseInt(req.query.count)
  maxCount = 0;
  maxPosts()
    .then (count) ->
      maxCount = count
      loadPosts()
    .then (posts) ->
      data = 
        posts: posts
        moreDefinitions: maxCount > (PER_PAGE + skip)
      html = render('index', data)
      SendHTML(req, res, html)


BlogRouter.get '/new', Middleware.auth, (req, res) ->
  html = fs.readFileSync VIEW_DIR+'new.html'
  SendHTML(req, res, html)

BlogRouter.get '/edit/:id/:slug', Middleware.auth, (req, res) ->
  Models.Post.findOne(_id: req.params.id).exec()
    .then (post) ->
      html = render 'edit', post
      SendHTML(req, res, html)
      

BlogRouter.post '/new', Middleware.auth, (req, res) ->
  req.body.slug = req.body.title.replace(/\s+/g, '-').toLowerCase()
  new Models.Post(req.body).save (err, post) ->
    if err
      res.json err
    else
      res.json
        url: "/blog/#{post.id}/#{post.slug}"

BlogRouter.post '/:id', Middleware.auth, (req,res) ->
  req.body.slug = req.body.title.replace(/\s+/g, '-').toLowerCase()
  Models.Post.findByIdAndUpdate(req.params.id, req.body)
    .exec()
    .then (post) ->
      res.json
        url: "/blog/#{post.id}/#{post.slug}"

BlogRouter.get '/:id', (req, res) ->
  Models.Post.findOne(_id: req.params.id).exec (err, post) ->
  if err
    res.redirect "/"
  else
    res.redirect "/#{post.id}/#{post.slug}"

BlogRouter.get '/:id/:slug', (req, res) ->
  Models.Post.findOne(_id: req.params.id).exec (err, post) ->
    html = Markdown.parse(post.body)
    SendHTML(req, res, html)

BlogRouter.on 'mount', (parent) =>
	@parent = parent


module.exports = BlogRouter
