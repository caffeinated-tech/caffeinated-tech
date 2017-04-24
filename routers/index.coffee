module.exports = (Server) ->
  Server.use '/v/glossary', require('./glossary')
  Server.use '/v/blog', require('./blog')
  Server.use '/v/admin', require('./admin')
