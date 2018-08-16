# Rust on Android

This repository contains everything that is required to build executables that run on android or ARMv7 Linux Hardfloat devices. It uses `musl` to build static binaries.

> This will not create an android app. It will create a standalone ELF file that can be run on rooted android devices.


## Usage

* Docker is required in order to build the app.

Download the repository:
```
git clone https://github.com/andybitz/rust-on-android
```

Build the required Docker Image. This can take a while and might fail sometimes, but you can just restart if that should happen. It is responsible for downloading and building `musl` with `musl-cross-make`. It will also download and install rust in an extra docker image that can later be run in order to compile for the correct target.
```
./prebuild.sh
```

> This will also produce a lot of useless images on your machine which can get quite huge. You might want to clean them up later.

After the build completes you can just build your executuable.
```
./build
```

Or for production:
```
./build --release
```

Every argument will just get passed on to `cargo build`.


### Getting the binary on the device with `adb`

You can use any method you like, but here is an example with `adb`, a tool made by google to debug android devices.

1. Push the binary to the device: `adb push target/armv7-unknown-linux-musleabihf/release/rust-on-android /sdcard/Download`. This will put the binary to the devices Download folder.
2. Start the interactive shell: `adb shell`.
3. Switch to root: `su`.
4. Remount `/system` to be writable: `mount -o remount,rw /system /system`.
5. Copy the binary to the `/system` folder: `cp /sdcard/Download/rust-on-android /system/`.
6. Allow execution: `chmod 750 /system/rust-on-android`.
7. Execute: `./system/rust-on-android`. And you are done.

> I used `/system` but any folder will to fine, as long as it allows execution and is writeable.


## Why

You could write your own programms that you can run on your device. You won't have any Android APIs but you can use Rust and access everything on the device from a really low level.
