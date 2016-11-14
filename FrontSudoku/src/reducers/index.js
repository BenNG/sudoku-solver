import { combineReducers } from 'redux';

import * as greetings from './greetings'; 
import * as color from './color'; 

export default combineReducers(Object.assign(
  greetings,
  color,
));