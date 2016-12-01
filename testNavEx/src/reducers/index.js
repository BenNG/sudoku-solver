import { combineReducers } from 'redux';

import * as gallery from './gallery';
import * as navigation from './navigation';
import * as drawer from './drawer';

export default combineReducers(Object.assign(
  navigation,
  gallery,
  drawer,
));