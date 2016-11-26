import { combineReducers } from 'redux';

import * as gallery from './gallery';
import * as navigation from './navigation';

export default combineReducers(Object.assign(
  navigation,
  gallery,
));