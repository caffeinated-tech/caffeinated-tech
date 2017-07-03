module.exports = (Server) ->
  Server.use '/v/glossary', require('./glossary')
  Server.use '/v/blog', require('./blog')
  Server.use '/v/admin', require('./admin')
  Server.use '/v/home', require('./home')
  Server.use '/v/contact', require('./contact')
  Server.use '/v/profile', require('./profile')
  Server.use '/v/mailing_list', require('./mailing_list')