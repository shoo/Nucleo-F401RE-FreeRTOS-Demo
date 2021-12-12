# Nucleo-F401RE-FreeRTOS-Demo
Nucleo-F401REボードを使ってFreeRTOSとD言語を協調させるデモ


# ビルド方法

```sh
make
```

またはWindowsでは以下。<sup>※`C:\msys64`にmsys2を、`C:\gcc-arm-none-eabi`にGNU Arm Embedded Toolchainをインストールした想定</sup>


```bat
C:\msys64\mingw64\bin\mingw32-make.exe all GCC_PATH=C:/gcc-arm-none-eabi/bin MKDIR="cmd /C mkdir"
```


