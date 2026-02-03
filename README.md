# Godot SDL Gyro

GDextention that allows to read Gyro from a controller in Godot 4, it utilizes
SDL and JibbSmart
[GamepadMotionHelpers](https://github.com/JibbSmart/GamepadMotionHelpers)
libraries

## Why this fork exists

For my own purposes, I need to build the library "templates". I run a silly
distro, so instead of redoing this work each time, I figured I'd post it.

You run my flake w/ `nix develop`, if you are on a x86 Nix system.

## Usage

Download the latest build from
[Here](https://github.com/SagaPDev/Godot-SDL-Gyro/releases/latest/download/godot-sdl-gyro-addon.zip),
extract the `addons` folder and place it in the root of your project

In your GDscript make a new SDLGyro object

```
...
var Gyro=SDLGyro.new()
...
```

Initialise SDL and The controller ready function

```
...
func _ready():
  Gyro.sdl_init()
  Gyro.controller_init()
...
```

Call any of the following functions in the process function.

```
      gamepad_polling()            //returns controller orientation(this function needs to be called so that the others can work)

      calibrate()                //starts continous calibrations
      stop_calibrate()           //stops continius calibration

      get_player_space()          //not working
      get_world_space()           //not working
      get_gravity()               //not working

      get_calibrated_gyro()        //retutns the controller's angular velocity in degrees per second
      get_processed_acceleration() //returns the controller's current acceleration in g-force with gravity removed
```

## Build Instructions

For all builds, make sure you have `SDL2` or any other compatible SDL library
installed on your system. For MacOS this is as simple as `brew install sdl2`. If
you're using Linux, I trust you can figure it out :) Windows has more specific
instructions because it's a pain.

Make sure you also have `pkg-config` and `scons` installed.

### Windows

As SDL2 is no longer in development, and SDL2-compat doesn't have a mingw
branch, you're gonna have to get creative, if you don't want to start digging
through old builds. I recommend using the MSYS2 MINGW64 shell, and installing
all dependencies. Once in the terminal, run...

```
pacman -Syu
pacman -S --needed base-devel mingw-w64-x86_64-toolchain
pacman -S mingw-w64-x86_64-python
pacman -S mingw-w64-x86_64-scons
pacman -S mingw-w64-x86_64-SDL2
```

There are 6 supported platforms...

```
linux, macos, windows, android, ios, web
```

There are 3 potential build targets...

```
template_release, template_debug editor
```

```
git clone https://github.com/SagaPDev/Godot-SDL-Gamepad-Test.git
cd Godot-SDL-Gamepad-Test
git submodule update --init --recursive
scons platform=windows target=<platform>
```

### Linux

```
git clone https://github.com/SagaPDev/Godot-SDL-Gamepad-Test.git
cd Godot-SDL-Gamepad-Test
git submodule update --init --recursive
scons platform=linux target=<platform>
```

### MacOS

MacOS's build is complicated by there being multiple popular architectures. I
only bothered to build for `arm64`, but nothing is stopping you from building
something else. Make sure you have an SDL2 package which supports the
architecture you're linking for.

```
arm64, x86_64, universal
```

```
git clone https://github.com/SagaPDev/Godot-SDL-Gamepad-Test.git
cd Godot-SDL-Gamepad-Test
git submodule update --init --recursive
scons platform=linux target=<platform> arch=<arch>
```

## TO DO

Hot Plugin  
Suport for Multiple Gamepads  
Release on Godot's Asset Library

## Aditional Credits

Source of the
[3Dmodel](https://sketchfab.com/3d-models/ps4-controller-from-3d-controller-overlay-d8569dc4e3af46a4b137f2926423f195)
by [larf](https://sketchfab.com/larf)
