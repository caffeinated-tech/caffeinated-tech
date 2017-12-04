import React from 'react';
import { Link } from 'react-router-dom';

class Header extends React.Component {
   render() {
      return (
        <div>
          <Link to={'/'}>
            <img className="logo" alt="caffeinated-tech-logo" src="images/ct-inverted-logo.png"/>
            <h1 className="centered">  
              caffeinated.tech
            </h1>
          </Link>
          <div className="row nav-links">
            <div className="three columns inverted blog">
              <Link to={"/blog"}>Blog</Link>
            </div>
            <div className="three columns inverted glossary">
              <Link to={"/glossary"}>Glossary</Link>
            </div>
            <div className="three columns inverted contact">
              <Link to={"/contact"}>Contact</Link>
            </div>
            <div className="three columns inverted cv">
              <Link to={"/profile"}>Profile</Link>
            </div>
          </div>
        </div>
      );
   }
}
export default Header;