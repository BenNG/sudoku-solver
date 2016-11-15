import { combineReducers } from 'redux';

import * as greetings from './greetings'; 
import * as color from './color'; 
import * as navigation from './navigation'; 

export default combineReducers(Object.assign(
  greetings,
  color,
  navigation,
));