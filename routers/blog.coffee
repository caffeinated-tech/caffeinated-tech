
VIEW_DIR = './public/views/blog/'

render = (templateFile, data = {}) ->
	template = fs.readFileSync VIEW_DIR + templateFile
	doT.template(template)(data)

loadPosts = (skip = 0) ->
  Models.Post.find()
    .sort(createdAt: -1)
    .limit(3)
    .skip(skip)
    .exec()

BlogRouter = express()

BlogRouter.get '/', (req,res) ->
	loadPosts().then (posts) ->
		viewData = 
      posts: for post in posts
	      post.blurbHTML()
    res.send render('index.html', viewData)

BlogRouter.get '/more', (req,res) ->
	posts = Models.Post.find()
		.sort(createdAt: -1)
		.limit(3)
		.skip(parseInt(req.query.count))  
		.exec (err, posts) ->
			posts = (post.blurbHTML() for post in posts).join("\n")
			res.send posts

BlogRouter.get '/new', (req, res) ->
# BlogRouter.get '/new', Middleware.auth, (req, res) ->
  console.log "new blog post"
  res.send render('new.html')

# BlogRouter.get '/edit/:id', Middleware.auth, (req, res) ->
BlogRouter.get '/edit/:id/:slug', (req, res) ->
  # console.log 'BlogRouter get edit fiew'
	Models.Post.findOne(_id: req.params.id).exec (err, post) ->
		if err
			res.redirect '/'
		else
			res.send render('edit.html',post)

BlogRouter.post '/edit/:id', (req,res) ->
  Models.Posts
    .findByIdAndUpdate(req.params.id, req.body)
    .exec()
    .then (post) ->
      console.log 'found a post', post
      res.json
        url: "/v/blog/#{post.id}/#{post.slug}"

# BlogRouter.post '/new', Middleware.auth, (req, res) ->
BlogRouter.post '/new', (req, res) ->
	req.body.slug = req.body.title.replace(/\s+/g, '-').toLowerCase()
	new Models.Post(req.body).save (err, post) ->
		if err
			res.send err
		else
			res.json
				url: "/v/blog/#{post.id}/#{post.slug}"

BlogRouter.get '/:id/:slug', (req, res) ->
  console.log 'find a post, please'
  Models.Post.findOne(_id: req.params.id).exec (err, post) ->
    console.log 'show post', post.body
    console.log 'markdown rendered', Markdown.parse(post.body)
    res.send Markdown.parse(post.body)

BlogRouter.on 'mount', (parent) =>
	@parent = parent


module.exports = BlogRouter
