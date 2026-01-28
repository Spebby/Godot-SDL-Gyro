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

in your GDscript make a new SDLGyro object

```
...
var Gyro=SDLGyro.new()
...
```

initialize SDL and The controller ready function

```
...
func _ready():
  Gyro.sdl_init()
  Gyro.controller_init()
...
```

call any of the folloing functions in the process fuction

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

### Windows

As SDL2 is no longer in development, and SDL2-compat doesn't have a mingw branch, you're gonna have to get creative, if you don't want to start digging through old builds. I recommend using the MSYS2 MINGW64 shell, and installing all dependencies. Once in the terminal, run...

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
scons platform=windows target=<platform>
```

### Linux

```
git clone https://github.com/SagaPDev/Godot-SDL-Gamepad-Test.git
cd Godot-SDL-Gamepad-Test
scons platform=linux target=<platform>
```

## TO DO

Hot Plugin  
Suport for Multiple Gamepads  
Release on Godot's Asset Library

## Aditional Credits

Source of the
[3Dmodel](https://sketchfab.com/3d-models/ps4-controller-from-3d-controller-overlay-d8569dc4e3af46a4b137f2926423f195)
by [larf](https://sketchfab.com/larf)
