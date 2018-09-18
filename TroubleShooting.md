# pic-build-cui-linux
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](./LICENSE)

## Trouble Shooting

### 1. ユーザにデバイスファイルへの権限がない
```bash
$ make erasew
```
```
./tool/ipecmd.sh -P12F1822 -TPPK3 -E -W
libusb couldn't open USB device /dev/bus/usb/001/020: Permission denied.
libusb requires write access to USB device nodes.
libusb couldn't open USB device /dev/bus/usb/001/020: Permission denied.
libusb requires write access to USB device nodes.
libusb couldn't open USB device /dev/bus/usb/001/020: Permission denied.
libusb requires write access to USB device nodes.
*****************************************************
The target circuit may require more power than the debug tool can provide. An external power supply might be necessary.
Connection Failed.
libusb couldn't open USB device /dev/bus/usb/001/020: Permission denied.
libusb requires write access to USB device nodes.
libusb couldn't open USB device /dev/bus/usb/001/020: Permission denied.
libusb requires write access to USB device nodes.
*****************************************************
The target circuit may require more power than the debug tool can provide. An external power supply might be necessary.
Connection Failed.
Erase Target Failed.
Makefile:59: recipe for target '_erasew' failed
make: [_erasew] Error 7 (無視されました)
rm -f MPLABXLog.xml MPLABXLog.xml.1 MPLABXLog.xml.2 MPLABXLog.xml.3 MPLABXLog.xml.4 MPLABXLog.xml.5 MPLABXLog.xml.6 log.0
```

> libusb couldn't open USB device /dev/bus/usb/001/020: Permission denied.

デバイスファイル(/dev/bus/usb/001/020)の権限がないため, エラーになっているようだ.

解決策としては, Writer(Pickit 3)をUSBポートから抜き差しすると直る場合がある.  
それでも直らない場合, デバイスファイルの権限を変更する必要がある.(※管理者権限が必要)    

手順は以下のとおり.  

まず, デバイスファイルの権限の確認をする.

```bash
$ ls -l /dev/bus/usb/001/
```
```
...
crw-r--r-- 1 root root 189, 19 Sep 18 19:15 020
...
```

一般ユーザにはR/W権限がないみたいだ.  
デバイスファイルの権限を`666`に変更することにより, デバイスへのR/Wが可能になる.

```bash
$ sudo chmod 755 /dev/bus/usb/001/020
$ ls -l /dev/bus/usb/001/
```
```
...
crwxrw-rw- 1 root root 189, 19 Sep 18 19:24 020
...
```

この状態で実行できるかどうか確認する.

```bash
$ make erasew
```
```
./tool/ipecmd.sh -P12F1822 -TPPK3 -E -W
*****************************************************
Connecting to MPLAB PICkit 3...
Currently loaded firmware on PICkit 3
Firmware Suite Version.....01.54.00
Firmware type..............Enhanced Midrange
Programmer to target power is enabled - VDD = 5.000000 volts.
Target device PIC12F1822 found.
Device ID Revision = 9
Erasing...
Erase successful
Operation Succeeded
rm -f MPLABXLog.xml MPLABXLog.xml.1 MPLABXLog.xml.2 MPLABXLog.xml.3 MPLABXLog.xml.4 MPLABXLog.xml.5 MPLABXLog.xml.6 log.0
```

無事, 実行できたようだ.    


#### FYI

Env: Ubuntu 18.04  

USBのデバイスファイルのパスは下記の手順で確認できる.

```bash
$ lsusb
```
```
...
Bus 001 Device 020: ID 04d8:900a Microchip Technology, Inc. PICkit3
...
```

Bus番号(001)とDevice番号(020)が, 以下のように/dev/bus/usb/配下のパスとリンクしている.

```
/dev/bus/usb/"Bus番号(001)"/"デバイス番号(020)"
```

### 2. 随時追加
