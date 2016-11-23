import { combineReducers } from 'redux';

import * as navigation from './navigation'; 

export default combineReducers(Object.assign(
  navigation,
));