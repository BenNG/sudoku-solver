# Sudoku-solver

## Usage
* You need to have [Elixir 1.4.0](http://elixir-lang.org/install.html#unix-and-unix-like) on your system
* Install the depedencies
```
mix deps.get # (npm install for elixir)
```
* start the app
```
iex -S mix
```
* send a request
```
curl --request GET \ 
  --url 'http://localhost:5454/sudokus?input=000604700706000009000005080070020093800000005430010070050200000300000208002301000'

```

## Release process
```
# update mix.exs to bump the release version
mix deps.get
MIX_ENV=prod mix compile --no-debug-info
MIX_ENV=prod mix release
git push # the release ~ 12mo
# update the server with the hosts-provisionning repo
# TODO add the restart command at the end of the deploiement process
rel/sudoku/bin/sudoku start # bug: even after stop the old release is running --> htop kill
```

## tips
### React Native app
- after installed react-native-camera-roll don't forget to react-native link !
- update android build tools!
  - tools/android list sdk -a |grep Build
  - tools/android update sdk -a -u -t 8 
- Errors
  - message: Multiple dex files define Landroid/support/v7/appcompat/R$anim;
  - solution: I was getting the same error (not sure if it was related to react-native-image-picker) but running cd android && ./gradlew clean fixed the issue for me.