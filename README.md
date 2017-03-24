# NPPWeatherBot

## Setup
### Update to latest version of Nerves
    mix archive.install https://github.com/nerves-project/archives/raw/master/nerves_bootstrap.ez
### Make a new project
    mix nerves.new npp_weather_bot --module NPPWeatherBot
    cd npp_weather_bot
### Set the target in your shell
    export MIX_TARGET=rpi3
> you'll need to do this every time you open a new shell

## Wifi
See the [`nerves_interim_wifi`](https://github.com/nerves-project/nerves_interim_wifi) module and 
the [hello\_wifi](https://github.com/nerves-project/nerves-examples/tree/master/hello_wifi) 
example project.

>#### Note:

> On ACU campus wifi you will need to use the "BasicACUwifi" network. Connecting to this 
network utilizes a [captive portal](https://en.wikipedia.org/wiki/Captive_portal) which 
will require you to register your devices MAC address using your ACU credentials. 
The easiest way to do this is by:

>1. Get your raspberry pi’s MAC address 
 - Boot into Raspbian or some other flavor of Linux
 - Open the terminal (if in the GUI)
 - run `cat /sys/class/net/wlan0/address`
2. Go [here](https://clearpass.acu.edu/guest/auth_login.php?target=%2Fguest%2Fmac_create.php) 
(while behind the ACU firewall)
3. Sign-in using ACU credentials
4. Enter a Device Name; Device Type: Other; MAC Address: <MAC ADDR OF RPI3>

If your weather station will be running on a different network be sure to change the config 
setting for `:ssid`, `:key_mgmt`, and `:psk`

## Temperature

## Twitter

## WeatherServer

## Scheduling