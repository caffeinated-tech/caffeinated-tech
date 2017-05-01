
GlossaryRouter = express()

VIEW_DIR = './public/views/glossary/'
PER_PAGE = 3

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
      res.send(render('index', data))

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
      res.send(render('index', data))

GlossaryRouter.get '/new', Middleware.auth, (req, res) ->
  res.sendFile './new.html', SEND_FILE_OPTIONS

GlossaryRouter.post '/new', Middleware.auth, (req, res) ->
  req.body.slug = req.body.title.replace(/\s+/g, '-').toLowerCase()
  new Models.Definition(req.body).save (err, post) ->
    if err
      res.send err
    else
      res.json
        url: "/v/glossary/#{post.id}/#{post.slug}"


GlossaryRouter.get '/edit/:id/:slug', Middleware.auth, (req,res) ->
  console.log '/edit/:id', req.params.id
  Models.Definition.findOne( _id: req.params.id).exec()
    .then (definition) ->
      console.log 'found a definition, nowrenderingit'
      res.send render 'edit', definition
      

GlossaryRouter.post '/:id', Middleware.auth, (req,res) ->
  Models.Definition
    .findByIdAndUpdate(req.params.id, req.body)
    .exec()
    .then (definition) ->
      console.log 'found a definition', definition
      res.json
        url: "/v/glossary/#{definition.id}/#{definition.slug}"

GlossaryRouter.get '/:id/:slug', (req, res) ->
  Models.Definition
    .findOne(_id: req.params.id)
    .exec (err, definition) ->
      if err
        res.send err
      else
        res.send Markdown.parse(definition.body)

GlossaryRouter.on 'mount', (parent) =>
  console.log 'mounted Glossary'

module.exports = GlossaryRouter
