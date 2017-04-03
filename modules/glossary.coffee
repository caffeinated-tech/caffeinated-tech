bodyParser = require('body-parser')
express = require('express')

GlossaryModule = 
  parent: null
  router: express()
# GlossaryModule.router.use(bodyParser.json())

GlossaryModule.router.get '/', (req,res) ->
  definitions = Models.Definition.find()
    .sort(createdAt: -1)
    .limit(3)
    .exec (err, definitions) ->
      definitions = (definition.blurbHTML() for definition in definitions).join("\n")
      top = fs.readFileSync('./public/views/glossary.html')
      res.send """
        #{top}
        #{definitions}
        <div class="row bottom">
          <div class="twelve columns">
            <a class="button button-primary" id="load-more-definitions">View more</a>
          </div>
        </div>
      """

GlossaryModule.router.get '/more', (req,res) ->
  definitions = Models.Definition.find()
    .sort(createdAt: -1)
    .limit(3)
    .skip(parseInt(req.query.count))  
    .exec (err, definitions) ->
      definitions = (definition.blurbHTML() for definition in definitions).join("\n")
      res.send definitions

GlossaryModule.router.get '/new', Middleware.auth, (req, res) ->
  res.sendFile './new_definition.html', SEND_FILE_OPTIONS

GlossaryModule.router.post '/new', Middleware.auth, (req, res) ->
  req.body.slug = req.body.title.replace(/\s+/g, '-').toLowerCase()
  new Models.Definition(req.body).save (err, definition) ->
    if err
      res.send err
    else
      res.json
        url: "/v/glossary/#{definition.id}/#{definition.slug}"

GlossaryModule.router.get '/:id/:slug', (req, res) ->
  Models.Definition
    .findOne(_id: req.params.id)
    .exec (err, definition) ->
      if err
        res.send err
      else
        res.send definition.body

GlossaryModule.router.on 'mount', (parent) =>
  @parent = parent


module.exports = GlossaryModule
