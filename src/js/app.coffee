React = require('react')
{ Switch, Route, BrowserRouter, Link  } = require('react-router-dom')
{div, main } = require('react-dom')

Header = require('./header.jsx')
Footer = require('./footer.jsx')
Home = require('./home.jsx')
Blog = require('./blog.jsx')
Contact = require('./contact.jsx')
NoMatch = require('./no_match.jsx')


class App extends React.Component
  render: =>
    div
      id: 'page'
      Header()
      main
        className: 'not-a-container'
          Switch
            Route
              exact: true
              path: '/'
              component: Home
            Route
              path:'/blog'
              component: Blog
            Route
              path: '/contact'
              component: Contact
            Route
              component: NoMatch
          Footer()

class ClientPage extends React.Component {
  render() {
    return (
      BrowserRouter
        App
      BrowserRouter
      )
  }
}

export { App, ServerPage, ClientPage }