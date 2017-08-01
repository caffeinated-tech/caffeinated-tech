
GlossaryRouter = express()

VIEW_DIR = './public/views/glossary/'
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

maxDefinitions = ->
  Models.Definition
    .count()
    .exec()

loadDefinitions = (skip = 0) ->
  Models.Definition.find()
    .sort(createdAt: -1)
    .limit(3)
    .skip(PER_PAGE)
    .exec()

# list the first 3 definitions and their blurbs
GlossaryRouter.get '/', (req,res) ->
  maxCount = 0;
  maxDefinitions()
    .then (count) ->
      maxCount = count
      loadDefinitions()
    .then (definitions) ->
      data = 
        definitions: definitions
        moreDefinitions: maxCount > PER_PAGE
      html = render('index', data)
      SendHTML(req, res, html)

# get the next 3 definitions
GlossaryRouter.get '/more', (req,res) ->
  skip = parseInt(req.query.count)
  maxCount = 0;
  maxDefinitions()
    .then (count) ->
      maxCount = count
      loadDefinitions()
    .then (definitions) ->
      data = 
        definitions: definitions
        moreDefinitions: maxCount > (PER_PAGE + skip)
      html = render('index', data)
      SendHTML(req, res, html)


# Edit view for a new definition
GlossaryRouter.get '/new', Middleware.auth, (req, res) ->
  res.sendFile './new.html', SEND_FILE_OPTIONS
  html = fs.readFileSync VIEW_DIR+'new.html'
  SendHTML(req, res, html)

# Save a new definition and return the url to view it
GlossaryRouter.post '/new', Middleware.auth, (req, res) ->
  req.body.slug = req.body.title.replace(/\s+/g, '-').toLowerCase()
  new Models.Definition(req.body).save (err, post) ->
    if err
      res.json err
    else
      res.json
        url: "/glossary/#{post.id}/#{post.slug}"

# Edit view for an existing definition
GlossaryRouter.get '/edit/:id/:slug', Middleware.auth, (req,res) ->
  Models.Definition.findOne( _id: req.params.id).exec()
    .then (definition) ->
      html = render 'edit', definition
      SendHTML(req, res, html)
      

# Update a definition and return the url to view it
GlossaryRouter.post '/:id', Middleware.auth, (req,res) ->
  Models.Definition
    .findByIdAndUpdate(req.params.id, req.body)
    .exec()
    .then (definition) ->
      res.json
        url: "/glossary/#{definition.id}/#{definition.slug}"

GlossaryRouter.get '/:id/:slug', (req, res) ->
  Models.Definition
    .findOne(_id: req.params.id)
    .exec (err, definition) ->
      if err
        res.redirect '/glossary'
      else
        html = Markdown.makeHtml(definition.body)
        SendHTML(req, res, html)

GlossaryRouter.on 'mount', (parent) =>
  console.log 'mounted Glossary'

module.exports = GlossaryRouter
