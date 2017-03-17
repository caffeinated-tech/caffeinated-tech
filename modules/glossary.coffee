GlossaryModule = 
  parent: null
  router: require('express')()

GlossaryModule.router.get '/', (req,res) ->
  res.sendFile './glossary.html', SEND_FILE_OPTIONS

GlossaryModule.router.on 'mount', (parent) =>
  @parent = parent


module.exports = GlossaryModule
