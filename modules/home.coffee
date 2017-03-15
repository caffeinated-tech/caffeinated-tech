HomeModule = 
  parent: null
  router: require('express')()

HomeModule.router.get '/', (req,res) ->
  res.sendFile './index.html', SEND_FILE_OPTIONS

HomeModule.router.on 'mount', (parent) =>
  @parent = parent


module.exports = HomeModule
