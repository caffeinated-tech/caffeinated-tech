import React from 'react';
import ReactDOM from 'react-dom';
import { ClientPage } from './app.jsx';
import './stylesheets/index.scss'
 
function run(){
	ReactDOM.hydrate(<ClientPage/>, document.querySelector('#app-mount'));
}

window.addEventListener('DOMContentLoaded', run, false);
