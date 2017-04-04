module.exports = (Server) ->
  
  Server.use '/v/glossary', require('./glossary')
