import React from 'react';
import { Switch, Route, BrowserRouter, Link  } from 'react-router-dom';
import Header from './header.jsx';
import Footer from './footer.jsx';


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
        <div  class="flow-text row">
          <div>
            <h2 className="blue darken-2 z-depth-5">
              BLOG
            </h2>
          </div>
          <div>
            <Link to={"/blog/post/first"}>
              <h3 className="blue darken-2 z-depth-4">
              Fuck this shit
              </h3>
            </Link>

            <div className="col s12">
              <p>
                Look, just because I don't be givin' no man a foot massage don't make it right for Marsellus to throw Antwone into a glass motherfuckin' house, fuckin' up the way the nigger talks. Motherfucker do that shit to me, he better paralyze my ass, 'cause I'll kill the motherfucker, know what I'm sayin'? 
              </p>
              <p>
                You think water moves fast? You should see ice. It moves like it has a mind. Like it knows it killed the world once and got a taste for murder. After the avalanche, it took us a week to climb out. Now, I don't know exactly when we turned on each other, but I know that seven of us survived the slide... and only five made it out. Now we took an oath, that I'm breaking now. We said we'd say it was the snow that killed the other two, but it wasn't. Nature is lethal but it doesn't hold a candle to man. 
              </p>
              <blockquote>
                This is an example quotation that uses the blockquote tag.
              </blockquote>
            </div>
            <div className="col s6">
              <p>
                Normally, both your asses would be dead as fucking fried chicken, but you happen to pull this shit while I'm in a transitional period so I don't wanna kill you, I wanna help you. But I can't give you this case, it don't belong to me. Besides, I've already been through too much shit this morning over this case to hand it over to your dumb ass. 
              </p>
              <p>
                Normally, both your asses would be dead as fucking fried chicken, but you happen to pull this shit while I'm in a transitional period so I don't wanna kill you, I wanna help you. But I can't give you this case, it don't belong to me. Besides, I've already been through too much shit this morning over this case to hand it over to your dumb ass. 
              </p>
            </div>

            <div className="col s6">
              <div class="card blue darken-2">
                <span class="card-title">Card Title</span>
                <div class="card-content">
                  <p>I am a very simple card. I am good at containing small bits of information.
                  I am convenient because I require little markup to use effectively.</p>
                </div>
                <div class="card-action">
                  <a href="#">This is a link</a>
                </div>
              </div>
            </div>

          </div>
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
        <Header/>
        <main className="container">
          <Switch>
            <Route exact path='/' component={ Home } />
            <Route path="/blog" component={ Blog } />
            <Route path="/contact" component={ Contact } />
            <Route component={NoMatch}/>
          </Switch>
        </main>
        <Footer/>
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
          <div id="background">
          </div>
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