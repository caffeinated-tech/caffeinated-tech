module.exports = (Server) ->
  # Server.use '/glossary', require('./glossary')
  Server.use '/blog', require('./blog')
  Server.use '/admin', require('./admin')
  Server.use '/', require('./home')
  Server.use '/contact', require('./contact')
  Server.use '/profile', require('./profile')
  Server.use '/mailing_list', require('./mailing_list')

  # Temporarily adding in a link to my google doc CV
  Server.get 'cv', (req,res) ->
    res.redirect('https://docs.google.com/document/d/1UeHU3zjk2nhjys_PR1_nmD0nTSU6EUwu0hyCFH3nlww')
    
  Server.get '/robots.txt', (req,res)->
    res.type 'text/plain'
    res.send "User-agent: *\nDisallow: "
    
  Server.all '*', (req, res) ->
    res.redirect '/'

