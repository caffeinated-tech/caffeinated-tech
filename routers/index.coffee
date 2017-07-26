module.exports = (Server) ->
  Server.use '/glossary', require('./glossary')
  Server.use '/blog', require('./blog')
  Server.use '/admin', require('./admin')
  Server.use '/', require('./home')
  Server.use '/contact', require('./contact')
  Server.use '/profile', require('./profile')
  Server.use '/mailing_list', require('./mailing_list')