
GlossaryRouter = express()

VIEW_DIR = './public/views/glossary/'

render = (templateFile, data = {}) ->
  template = fs.readFileSync VIEW_DIR + templateFile
  doT.template(template)(data)

loadDefinitions = (skip = 0) ->
  Models.Definition.find()
    .sort(createdAt: -1)
    .limit(3)
    .skip(skip)
    .exec()


GlossaryRouter.get '/', (req,res) ->
  loadDefinitions()
    .then (definitions) ->
      definitions = for definition in definitions
        definition.blurbHTML()
      viewData = 
        definitions: definitions
      res.send render('index.html', viewData)
      

GlossaryRouter.get '/more', (req,res) ->
  skip = parseInt(req.query.count)

  loadDefinitions(skip)
    .then (definitions) ->
      definitions = for definition in definitions
        definition.blurbHTML()
      
      res.send definitions.join("\n")


GlossaryRouter.get '/new', Middleware.auth, (req, res) ->
  res.sendFile './new_definition.html', SEND_FILE_OPTIONS


# GlossaryRouter.get '/edit/:id', Middleware.auth, (req, res) ->
#   req.body.slug = req.body.title.replace(/\s+/g, '-').toLowerCase()
#   new Models.Definition(req.body).save (err, definition) ->
#     if err
#       res.send err
#     else
#       res.json
#         url: "/v/glossary/#{definition.id}/#{definition.slug}"

GlossaryRouter.post '/new', Middleware.auth, (req, res) ->
  res.sendFile './new_post.html', SEND_FILE_OPTIONS
        

GlossaryRouter.get '/edit/:id', Middleware.auth, (req,res) ->
  console.log '/edit/:id', req.params.id
  Models.Definition.findOne( _id: req.params.id).exec()
    .then (definition) ->
      console.log 'found a definition', definition
      res.send render('edit.html', definition)
      

GlossaryRouter.post '/edit/:id', Middleware.auth, (req,res) ->
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
        res.send definition.body

GlossaryRouter.on 'mount', (parent) =>
  console.log 'mounted Glossary'

module.exports = GlossaryRouter
