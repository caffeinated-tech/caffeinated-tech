import React from 'react';
import { Switch, Route, BrowserRouter  } from 'react-router-dom';
import Header from './header.jsx';


class Home extends React.Component {
   render() {
      return (
        <div>
          HOME
        </div>
      );
   }
}

class Blog extends React.Component {
   render() {
      return (
        <div>
          BLOG
        </div>
      );
   }
}

class Contact extends React.Component {
   render() {
      return (
        <div>
          Contact
        </div>
      );
   }
}
class NoMatch extends React.Component {
   render() {
      return (
        <div>
          404 not found
        </div>
      );
   }
}

class App extends React.Component {
   render() {
    return (
      <div id="page">
        <div className="container">
          <Header/>
          <div id='contents'>
            <div>
              HERE WE ARE AGAIN
            </div>
            <Switch>
              <Route exact path='/' component={ Home } />
              <Route path="/blog" component={ Blog } />
              <Route path="/contact" component={ Contact } />
              <Route component={NoMatch}/>
            </Switch>
          </div>
        </div>
      </div>
    );
  }
}

class ServerPage extends React.Component {
  render() {
    return (
      <html>
        <head>
          <meta charSet="utf-8"/>
          <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
          <meta name="author" content="liam@caffeinated.tech"/>
          <link rel="icon" href="images/favicon.png"/>
          <link href="https://fonts.googleapis.com/css?family=Fira+Sans" rel="stylesheet"/>
          <title> 
            Caffeinated Tech
          </title>
        </head>
        <body>
          <div id="app-mount">
            <App></App>
          </div>
          <script src="index.js">
          </script>
        </body>
      </html>
    );
  }
}

class ClientPage extends React.Component {
  render() {
    return (
      <BrowserRouter>
        <App/>
      </BrowserRouter>
      )
  }
}

export { App, ServerPage, ClientPage };