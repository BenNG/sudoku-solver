import { createStore, applyMiddleware, compose } from 'redux';
import createLogger from 'redux-logger';


const loggerMiddleware = createLogger({predicate: (getState, action) => __DEV__});

export default compose(
  applyMiddleware(
    loggerMiddleware,
  )
);

