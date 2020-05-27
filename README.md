# haxe-test-assigment

## Requirements
You could see requirements listed in [here](https://github.com/haxeui/hxWidgets).

## Build
Run `haxe build.hxml` once you installed hxWidgets via haxelib. 

## Run
To run application use `./bin/Main` on unix or `./bin/Main.exe` on windows.

## Possible problems
You could receive message that there are compiling errors in hxWidgets source files. There are two static overrided methods. Eventually there is no such thing in haxe as static virtual method or something. So as a quick fix it is possible to just remove 'override' from those functions definitions.
