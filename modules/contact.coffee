ContactModule = 
  parent: null
  router: require('express')()

ContactModule.router.get '/', (req,res) ->
  res.sendFile './contact.html', SEND_FILE_OPTIONS

ContactModule.router.on 'mount', (parent) =>
  @parent = parent


module.exports = ContactModule
