    import React from 'react';
    
    class Header extends React.Component {
       render() {
          return (
            <div id="page">
              <div className="container">
                <img className="logo" alt="caffeinated-tech-logo"
                  src="images/ct-inverted-logo.png"/>
                <a href="/">
                  <h1 className="centered">  
                    caffeinated.tech
                  </h1>
                </a>
                <div className="row nav-links">
                  <div className="three columns inverted blog">
                    <a href="/blog">Blog</a>
                  </div>
                  <div className="three columns inverted glossary">
                    <a href="/glossary">Glossary</a>
                  </div>
                  <div className="three columns inverted contact">
                    <a href="/contact">Contact</a>
                  </div>
                  <div className="three columns inverted cv">
                    <a href="/profile">Profile</a>
                  </div>
                </div>
              </div>
            </div>
          );
       }
    }
    export default Header;