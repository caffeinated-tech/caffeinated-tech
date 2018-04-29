################################################################################
# The full html page for the blog, including html, header, body and footer tags.
# This should be rendered by the server (or statically to file) and served to
#   to the client when requesting any route. The react router will handle the
#   rendering the requested page.
################################################################################

React = require('react')
{ StaticRouter } = require('react-router-dom')
{ html, head, meta, linhk, title, body, div, script } = require('react-dom')

App = require('./app')

class FullPage extends React.Component
  render: =>
    StaticRouter
      location: url
      context: {}
        html {},
          head {},
            meta
              charSet: 'utf-8'
            meta
              name: 'viewport'
              content: 'width=device-width, initial-scale=1.0'
            meta
              name: 'author'
              content: 'liam@caffeinated.tech'
            link
              rel: 'icon'
              href: 'images/favicon.png'
            link
              href: 'https://fonts.googleapis.com/css?family=Fira+Sans'
              rel: 'stylesheet'
            title
              'Caffeinated Tech'
          body {},
            div
              id: 'background'
            div
              id: 'app-mount'
              App()
            script
              src: 'index.js'

# Convert the component to a factory
FullPage = React.createFactory FullPage

# Wrap
FullPageAsHTML = (url) =>
  ReactDOMServer.renderToString
      FullPage()

module.exports =
