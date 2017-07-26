module.exports = (Server) ->
  Server.use '/glossary', require('./glossary')
  Server.use '/blog', require('./blog')
  Server.use '/admin', require('./admin')
  Server.use '/', require('./hom  e')
  Server.use '/contact', require('./contact')
  Server.use '/profile', require('./profile')
  Server.use '/mailing_list', require('./mailing_list')

  Server.get '/robots.txt', (req,res)->
    res.type 'text/plain'
    res.send "User-agent: *\nDisallow: "
    
  Server.get '*', (req, res) ->
    res.redirect '/'

