import * as types from './types';

export function goToHome(tab){
    return {
        type: types.SWITCH_TAB_TO_HOME,
        tab: "home",
    };
}
export function goToSudoku(tab){
    return {
        type: types.SWITCH_TAB_TO_SUDOKU,
        tab: "sudoku",
    };
}