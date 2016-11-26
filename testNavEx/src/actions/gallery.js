import * as types from './types';

export function selectedItem(uri) {
    return {
        type: types.SELECTED_ITEM,
        uri,
    };
}