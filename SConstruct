#!/usr/bin/env python
import os
import sys
import subprocess

env = SConscript("godot-cpp/SConstruct")


def pkg_config_flags(package):
    try:
        cflags = (
            subprocess.check_output(["pkg-config", "--cflags", package], text=True)
            .strip()
            .split()
        )
        libs = (
            subprocess.check_output(["pkg-config", "--libs", package], text=True)
            .strip()
            .split()
        )
        return cflags, libs
    except subprocess.CalledProcessError:
        print(f"Warning: pkg-config failed for {package}")
        return [], []


def parse_libs_to_scons(libs_output):
    """Parse pkg-config --libs output into SCons LIBS and LIBPATH"""
    libs = []
    libpaths = []
    other_flags = []
    
    for flag in libs_output:
        if flag.startswith("-l"):
            libs.append(flag[2:])  # Remove -l prefix
        elif flag.startswith("-L"):
            libpaths.append(flag[2:])  # Remove -L prefix
        else:
            other_flags.append(flag)
    
    return libs, libpaths, other_flags


# Use pkg-config for SDL2 on all platforms
if env["platform"] in ["linux", "windows"]:
    cflags, libs_flags = pkg_config_flags("sdl2")
    
    if cflags:
        env.Append(CCFLAGS=cflags)
    
    if libs_flags:
        libs, libpaths, other_flags = parse_libs_to_scons(libs_flags)
        env.Append(LIBS=libs)
        env.Append(LIBPATH=libpaths)
        if other_flags:
            env.Append(LINKFLAGS=other_flags)
    else:
        # Fallback if pkg-config isn't available
        print("Warning: pkg-config not found, using fallback SDL2 linking")
        env.Append(LIBS=["SDL2"])

sources = Glob("src/*.cpp")

# Windows-specific flags and system libraries
if env["platform"] == "windows":
    if env.get("use_mingw", False):
        env.Append(LINKFLAGS=["-Wl,--dynamicbase", "-Wl,--nxcompat"])
    
    # Add Windows system libraries that SDL2 depends on
    env.Append(LIBS=[
        "setupapi",
        "winmm",
        "imm32",
        "version",
        "ole32",
        "oleaut32",
        "cfgmgr32",
    ])

if env["platform"] == "macos":
    library = env.SharedLibrary(
        "Godot_Gamepad_SDLTest/addons/godot-sdl-gyro/sdlgyro.{}.{}.framework/sdlgyro.{}.{}".format(
            env["platform"], env["target"], env["platform"], env["target"]
        ),
        source=sources,
    )
else:
    library = env.SharedLibrary(
        "Godot_Gamepad_SDLTest/addons/godot-sdl-gyro/sdlgyro{}{}".format(
            env["suffix"], env["SHLIBSUFFIX"]
        ),
        source=sources,
    )

Default(library)