# Nucleo-F401RE-FreeRTOS-Demo
Nucleo-F401REボードを使ってFreeRTOSとD言語を協調させるデモ


# ビルド方法

事前に`dub.settings.json`を作成する。

```json
{
	"defaultPostGenerateEnvironments": {
		"LDSCRIPT": "STM32F401RETx_FLASH.ld",
		"LIBDIR": "",
		"LIBS": "-lc -lm -lnosys",
		"BUILD_DIR": "build",
		"TARGET": "application",
		"LD": "arm-none-eabi-gcc",
		"SZ": "arm-none-eabi-size",
		"CP": "arm-none-eabi-objcopy",
		"HEX": "arm-none-eabi-objcopy -O ihex",
		"BIN": "arm-none-eabi-objcopy -O binary -S"
	}
}
```

```sh
make
dub build -a=arm-none-eabi
```

またはWindowsでは以下。<sup>※`C:\msys64`にmsys2を、`C:\gcc-arm-none-eabi`にGNU Arm Embedded Toolchainをインストールした想定</sup>

```json
{
	"defaultPostGenerateEnvironments": {
		"LDSCRIPT": "STM32F401RETx_FLASH.ld",
		"LIBDIR": "",
		"LIBS": "-lc -lm -lnosys",
		"BUILD_DIR": "build",
		"TARGET": "application",
		"LD": "C:/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe",
		"SZ": "C:/gcc-arm-none-eabi/bin/arm-none-eabi-size.exe",
		"CP": "C:/gcc-arm-none-eabi/bin/arm-none-eabi-objcopy.exe",
		"HEX": "C:/gcc-arm-none-eabi/bin/arm-none-eabi-objcopy.exe -O ihex",
		"BIN": "C:/gcc-arm-none-eabi/bin/arm-none-eabi-objcopy.exe -O binary -S"
	}
}
```

```bat
C:\msys64\mingw64\bin\mingw32-make.exe lib GCC_PATH=C:/gcc-arm-none-eabi/bin "MKDIR=cmd /C mkdir"
dub build -a=arm-none-eabi
```

clangでビルドする場合は以下。

```json
{
	"defaultPostGenerateEnvironments": {
		"LDSCRIPT": "STM32F401RETx_FLASH.ld",
		"LIBDIR": "",
		"LIBS": "-lc -lm -lnosys",
		"BUILD_DIR": "build",
		"TARGET": "application",
		"LD": "C:/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe",
		"SZ": "C:/llvm/bin/llvm-size.exe",
		"CP": "C:/llvm/bin/llvm-objcopy.exe",
		"HEX": "C:/llvm/bin/llvm-objcopy.exe -O ihex",
		"BIN": "C:/llvm/bin/llvm-objcopy.exe -O binary -S"
	}
}
```

```bat
C:\msys64\mingw64\bin\mingw32-make.exe lib -j 8 "CC=C:/llvm/bin/clang.exe --sysroot=C:/gcc-arm-none-eabi/arm-none-eabi --target=arm-none-eabi -fshort-enums" "AS=C:/llvm/bin/clang.exe --sysroot=C:/gcc-arm-none-eabi/arm-none-eabi --target=arm-none-eabi -fshort-enums -x assembler-with-cpp" "LD=C:/gcc-arm-none-eabi/bin/arm-none-eabi-gcc.exe" "CP=C:/llvm/bin/llvm-objcopy.exe" "SZ=C:/llvm/bin/llvm-size.exe" "ASMOPTS=" "MKDIR=cmd /C mkdir"
dub build -a=arm-none-eabi
```


