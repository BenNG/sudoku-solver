# Sudoku

## React Native app
- after installed react-native-camera-roll don't forget to react-native link !
- update android build tools!
  - tools/android list sdk -a |grep Build
  - tools/android update sdk -a -u -t 8 
- Errors
  - message: Multiple dex files define Landroid/support/v7/appcompat/R$anim;
  - solution: I was getting the same error (not sure if it was related to react-native-image-picker) but running cd android && ./gradlew clean fixed the issue for me.
## You need elixir on your system
 - http://elixir-lang.org/install.html#unix-and-unix-like  
If everything is ok you should see something like this:
```
➜  elixir git:(f045705) elixir --version
Erlang/OTP 19 [erts-8.2] [source-fbd2db2] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false]

Elixir 1.4.0
➜  elixir git:(f045705) iex --version
Erlang/OTP 19 [erts-8.2] [source-fbd2db2] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false]

IEx 1.4.0
```

- try to load the app with  
```
iex -S mix
```