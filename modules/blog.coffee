BlogModule = 
  parent: null
  router: require('express')()

BlogModule.router.get '/', (req,res) ->
  res.sendFile './blog.html', SEND_FILE_OPTIONS

BlogModule.router.on 'mount', (parent) =>
  @parent = parent


module.exports = BlogModule
