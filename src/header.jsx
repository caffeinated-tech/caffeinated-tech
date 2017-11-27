    import React from 'react';
    
    class Header extends React.Component {
       render() {
          return (
            <div id="page">
              <div className="container">
                <img className="logo" alt="caffeinated-tech-logo"
                  src="dist/images/ct-inverted-logo.png"/>
                <a href="/">
                  <h1 class="centered">  
                    caffeinated.tech
                  </h1>
                </a>
                <div class="row nav-links">
                  <div class="three columns inverted blog">
                    <a href="/blog">Blog</a>
                  </div>
                  <div class="three columns inverted glossary">
                    <a href="/glossary">Glossary</a>
                  </div>
                  <div class="three columns inverted contact">
                    <a href="/contact">Contact</a>
                  </div>
                  <div class="three columns inverted cv">
                    <a href="/profile">Profile</a>
                  </div>
                </div>
              </div>
            </div>
          );
       }
    }
    export default Header;