# HOW TO USE SWD FROM RPi GPIOs
from https://learn.adafruit.com/programming-microcontrollers-using-openocd-on-raspberry-pi/overview

The OS used is Raspbian on a RPi 3B+:
- compile opencv to be able to use swd from GPIOs:
```
$ sudo apt-get update
$ sudo apt-get install git autoconf libtool make pkg-config libusb-1.0-0 libusb-1.0-0-dev
$ git clone http://openocd.zylin.com/openocd
$ cd openocd
$ ./bootstrap
$ ./configure --enable-sysfsgpio --enable-bcm2835gpio
$ make
$ sudo make install
```
- after you can list the available interfaces:
```
$ ls /usr/local/share/openocd/scripts/interface
```
- connect your processor to the SWD of the RPi
![Alt Text](raspberry_pi_SWDPinoutPi2.png)
image from the link above

- write the openocd.cfg file:  

bindto 0.0.0.0  
source [find interface/raspberrypi2-native.cfg]  

transport select swd  

bcm2835gpio_swd_nums 25 24  
bcm2835gpio_srst_num 18  

set WORKAREASIZE 1000  
adapter_khz 1  
source [find target/stm32f3x.cfg]  
reset_config srst_only srst_push_pull  
init  

- start openocd in the same directory than this file

- connect with arm-none-eabi-gdb from an other machine on the same network
```
arm-none-eabi-gdb --eval-command="target remote ip:3333"
```
to flash:
```
arm-none-eabi-gdb -ex="target remote 192.168.4.1:3333" -ex "load 500.elf" -ex "monitor reset" -ex "set confirm off" -ex "quit"
```
to debug:
```
arm-none-eabi-gdb -ex="target remote 192.168.4.1:3333"  -ex "monitor reset halt" -ex "set confirm off" 500.elf
```
