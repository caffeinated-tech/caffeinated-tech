BlogModule = 
  parent: null
  router: require('express')()

BlogModule.router.get '/', (req,res) ->
  res.send 'This is the blog home page'

BlogModule.router.on 'mount', (parent) =>
  @parent = parent


module.exports = BlogModule
