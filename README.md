# pic-build-tool

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](./LICENSE)

Linux 上で CUI のみで, PIC マイコンのソースコードを Build, Write する Makefile を作成したので公開する.

- [Enviroment](#enviroment)
  - [Hardware](#hardware)
  - [Software](#software)
- [Files](#files)
- [Make Rule](#make-rule)
- [Demo Program](#demo-program)
- [Demo](#demo)
- [Trouble Shooting](#trouble-shooting)
- [LICENSE](#license)

## Enviroment

### Hardware

- Writer: [Pickit 3](https://www.microchip.com/Developmenttools/ProductDetails/PG164130)
- Target MCU: [PIC12F1822](https://www.microchip.com/wwwproducts/en/PIC12F1822)

### Software

- OS: [Ubuntu 18.04](https://www.ubuntu.com/)
- Build Tool: [MPLAB® X IDE v5.30 for Linux](http://www.microchip.com/mplab/mplab-x-ide)
- Compiler: [MPLAB® XC8 Compliler v2.10 for Linux](http://www.microchip.com/mplab/compilers)

~/.bashrc に以下を追記[<sup>\*1</sup>](#note1).

```bash
export PATH="$PATH:'/opt/microchip/xc8/v2.10/bin'"
```

<a id="note1">\*1: XC8 をインストール時に, 追記するか問われる.</a>

## Files

```text
./
├── ./LICENSE
├── ./Makefile
├── ./README.md
├── ./TroubleShooting.md
├── ./circuit
│   ├── ./circuit/actual.jpg
│   ├── ./circuit/led_blink.svg
│   └── ./circuit/led_blink.txt
├── ./src
│   └── ./src/main.c
└── ./tool
    └── ./tool/ipecmd.sh
```

|File|Content|
|:--|:--|
|[./LICENSE](./LICENSE)|[LICENSE](#license)|
|[./Makefile](./Makefile)|今回公開したいもの|
|[./README.md](./README.md)|[これ](#pic-cui-build-linux)|
|[./TroubleShooting.md](./TroubleShooting.md)|[Trouble Shooting](#trouble-shooting) で使用|
|[./circuit/actual.jpg](./circuit/actual.jpg)|[Example](#example) で使用|
|[./circuit/led\_blink.svg](./circuit/led_blink.svg)|[Sample Program](#sample-program) に使用|
|[./circuit/led\_blink.txt](./circuit/led_blink.txt)|[goat](https://github.com/blampe/goat) で svg ファイルを生成するためのソース|
|[./src/main.c](./src/main.c)|デモ用プログラム|
|[./tool/ipecmd.sh](./tool/ipecmd.sh)|Microchip 社が提供する ipecmd.jar を呼び出すスクリプト|

## Sample Program

PIC12F1822 のピン番号 7 に接続された LED が 1 秒周期で点滅する.

![Circuit](circuit/led_blink.svg "Circuit")

## Example

```bash
make
```

```text
xc8-cc -mcpu=12F1822 -mwarn=-9 -o build/led_blink.hex src/main.c
src/main.c:34:: warning: (752) conversion to shorter data type

Memory Summary:
    Program space        used    1Fh (    31) of   800h words   (  1.5%)
    Data space           used     4h (     4) of    80h bytes   (  3.1%)
    EEPROM space         used     0h (     0) of   100h bytes   (  0.0%)
    Data stack space     used     0h (     0) of    70h bytes   (  0.0%)
    Configuration bits   used     2h (     2) of     2h words   (100.0%)
    ID Location space    used     0h (     0) of     4h bytes   (  0.0%)
```

```bash
make writew
```

```text
./tool/ipecmd.sh -P12F1822 -TPPK3 -Fbuild/led_blink.hex -M -W5.0
*****************************************************
Connecting to MPLAB PICkit 3...
Currently loaded firmware on PICkit 3
Firmware Suite Version.....01.56.02
Firmware type..............Enhanced Midrange
Programmer to target power is enabled - VDD = 5.000000 volts.
Target device PIC12F1822 found.
Device Revision ID = 9
Device Erased...
Programming...
The following memory area(s) will be programmed:
program memory: start address = 0x0, end address = 0x7ff
configuration memory
Programming/Verify complete
PICKIT3 Program Report
19-11-2019, 01:08:50
Device Type:PIC12F1822
Program Succeeded.
Operation Succeeded
```

![actual](./circuit/actual.jpg)

## Trouble Shooting

[./TroubleShooting.md](./TroubleShooting.md)を参照.

## LICENSE

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
