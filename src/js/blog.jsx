import {  Link  } from 'react-router-dom';
import React from 'react';

class Blog extends React.Component {
   render() {
      return (
        <div  className="flow-text row">
          <div className="col s12">
            <h2 className="blue darken-2">
              BLOG
            </h2>
          </div>
          <br/>
          <div className="col s12">
            <Link to={"/blog/post/first"}>
              <h3 className="blue darken-2">
                Fuck this shit
              </h3>
            </Link>
          </div>
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

        </div>

      );
   }
}

export default Blog;