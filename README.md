# SAGE AGI Library
SAGE AGI Library is a library of Haxe code for working with Sierra AGI games.

# Recommended Development Setup
The standard environment used for development is as follows:
* [Haxe 3.4.7](https://haxe.org/download/version/3.4.7/) - theoretically this should work with any newer version of Haxe.
* [Visual Studio Code](https://code.visualstudio.com/)
* [Haxe Extension Pack (for vscode, recommended rather than installing individual extensions)](https://marketplace.visualstudio.com/items?itemName=vshaxe.haxe-extension-pack)
* [Haxe Checkstyle (for vscode)](https://marketplace.visualstudio.com/items?itemName=vshaxe.haxe-checkstyle)

Standard build hxml and debugging configuration is included.

## Quick Commands to install VSCode Extensions
````
code --install-extension vshaxe.haxe-extension-pack
code --install-extension  vshaxe.haxe-checkstyle
````

## Required Haxelib's
````
haxelib install dox
haxelib install checkstyle
haxelib install hxcpp
````

## Build Commands
````
haxe build.hxml
````