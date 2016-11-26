# Sudoku

## React Native app
- after installed react-native-camera-roll don't forget to react-native link !
- update android build tools!
  - tools/android list sdk -a |grep Build
  - tools/android update sdk -a -u -t 8 
- Errors
  - message: Multiple dex files define Landroid/support/v7/appcompat/R$anim;
  - solution: I was getting the same error (not sure if it was related to react-native-image-picker) but running cd android && ./gradlew clean fixed the issue for me.