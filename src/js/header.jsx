import React from 'react';
import { Link } from 'react-router-dom';

class Header extends React.Component {
   render() {
      return (
        <header className="row">
          <div className="col s12">
            <Link to={'/'}>
              <img className="logo" alt="caffeinated-tech-logo" src="images/ct-inverted-logo.png"/>
              <h1 className="centered">  
                caffeinated.tech
              </h1>
            </Link>
          </div>
          <div className="col s3 blog">
            <Link to={"/blog"} className="waves-effect waves-light btn blue darken-2">
              Blog
            </Link>
          </div>
          <div className="col s3 glossary">
            <Link to={"/glossary"} className="waves-effect waves-light btn amber darken-2">
              Glossary
            </Link>
          </div>
          <div className="col s3 contact">
            <Link to={"/contact"} className="waves-effect waves-light btn green darken-2">
              Contact
            </Link>
          </div>
          <div className="col s3 profile">
            <Link to={"/profile"} className="waves-effect waves-light btn purple darken-2">
              Profile
            </Link>
          </div>
        </header>
      );
   }
}
export default Header;
          