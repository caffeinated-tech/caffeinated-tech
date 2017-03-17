CVModule = 
  parent: null
  router: require('express')()

CVModule.router.get '/', (req,res) ->
  res.sendFile './cv.html', SEND_FILE_OPTIONS

CVModule.router.on 'mount', (parent) =>
  @parent = parent


module.exports = CVModule
