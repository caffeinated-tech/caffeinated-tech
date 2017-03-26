bodyParser = require('body-parser')
express = require('express')

compileBlurb = (data) ->
  console.log '\n\ndata', data
  
  """
    <div class="section">
      <a href="v/glossary/#{data.id}/#{data.slug}">
        <h3 class="glossary">
          #{data.title}
        </h3>
      </a>
      <p>
        #{data.blurb}
      </p>
    </div>
  """

GlossaryModule = 
  parent: null
  router: express()
  definition: require './definition'

# GlossaryModule.router.use(bodyParser.json())

GlossaryModule.router.get '/', (req,res) ->
  definitions = GlossaryModule.definition.find()
    .sort(createdAt: -1)
    .limit(3)
    .exec (err, definitions) ->
      definitions = (compileBlurb(definition) for definition in definitions).join("\n")
      res.send """
        <h2 class="title glossary">
          <a href="v/glossary">
            Tech Glossary
          </a>
        </h2>
        #{definitions}
        <div class="row bottom">
          <div class="twelve columns">
            <a class="button button-primary" id="load-more-definitions">View more</a>
          </div>
        </div>
      """

GlossaryModule.router.get '/more', (req,res) ->
  definitions = GlossaryModule.definition.find()
    .sort(createdAt: -1)
    .limit(3)
    .skip(parseInt(req.query.count))  
    .exec (err, definitions) ->
      console.log err
      console.log definitions
      definitions = (compileBlurb(definition) for definition in definitions).join("\n")
      res.send definitions

GlossaryModule.router.get '/new', (req, res) ->
  res.sendFile './new_definition.html', SEND_FILE_OPTIONS

GlossaryModule.router.post '/new', (req, res) ->
  req.body.slug = req.body.title.replace(/\s+/g, '-').toLowerCase()
  new GlossaryModule.definition(req.body).save (err, definition) ->
    if err
      res.send err
    else
      res.json
        url: "/v/glossary/#{definition.id}/#{definition.slug}"

GlossaryModule.router.get '/:id/:slug', (req, res) ->
  GlossaryModule.definition
    .findOne(_id: req.params.id)
    .exec (err, definition) ->
      if err
        res.send err
      else
        console.log 'definition.body', definition 
        html = """
          <div class="title">
            <h2>
              <a href="v/glossary/#{definition.id}/#{definition.slug}">
                #{definition.title}
              </a>
            </h2>
            <i>Created: #{definition.createdAt} by #{definition.author}</i>
          </div>
        """ + definition.body
        res.send html

GlossaryModule.router.on 'mount', (parent) =>
  @parent = parent


module.exports = GlossaryModule
