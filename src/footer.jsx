import React from 'react';
import { Link } from 'react-router-dom';

class Footer extends React.Component {
   render() {
      return (
        <footer className="page-footer green darken-2">
          <div className="container">
            <div className="row">
              <div className="col s12">
                <h5 className="white-text center-align">
                  Made with &#9749; by Liam Krewer
                </h5>
              </div>
            </div>
          </div>
          <div className="footer-copyright">
            <div className="container">
            © 2017 Liam Krewer
            <Link to={"/contact"} className="grey-text text-lighten-4 right">
              Contact me
            </Link>
            </div>
          </div>
        </footer>
      );
   }
}
export default Footer;