    import React from 'react';
    
    import Header from './header.jsx';

    class App extends React.Component {
       render() {
          return (
            <html>
              <head>
                <meta charSet="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <meta name="author" content="liam@caffeinated.tech"/>

                <link rel="icon" href="images/favicon.png"/>
                <link rel="stylesheet" type="text/css" href="stylesheets/index.css"/>
                <link href="https://fonts.googleapis.com/css?family=Fira+Sans" rel="stylesheet"/>
                <title> 
                  Caffeinated Tech
                </title>
              </head>
              <body>
                <Header>
                </Header>
              </body>
            </html>
          );
       }
    }
    export default App;