# Nucleo-F401RE-FreeRTOS-Demo
Nucleo-F401REボードを使ってFreeRTOSとD言語を協調させるデモ


# ビルド方法

```sh
make
```

またはWindowsでは以下。<sup>※`C:\msys64`にmsys2を、`C:\gcc-arm-none-eabi`にGNU Arm Embedded Toolchainをインストールした想定</sup>


```bat
C:\msys64\mingw64\bin\mingw32-make.exe all GCC_PATH=C:/gcc-arm-none-eabi/bin "MKDIR=cmd /C mkdir"
```

clangでビルドする場合は以下。

```bat
C:\msys64\mingw64\bin\mingw32-make.exe all -j 8 "CC=C:/llvm/bin/clang.exe --sysroot=C:/gcc-arm-none-eabi/arm-none-eabi --target=arm-none-eabi -fshort-enums" "AS=C:/llvm/bin/clang.exe --sysroot=C:/gcc-arm-none-eabi/arm-none-eabi --target=arm-none-eabi -fshort-enums -x assembler-with-cpp" "LD=C:/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe" "CP=C:/llvm/bin/llvm-objcopy.exe" "SZ=C:/llvm/bin/llvm-size.exe" "ASMOPTS=" "MKDIR=cmd /C mkdir"
```


