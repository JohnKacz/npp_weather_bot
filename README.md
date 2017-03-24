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
We are using the DS18B20 temperature sensor

> There are two models that were purchased
The longer sensors wires are: red - 3.3v, yellow - GND, and green - Data
The shorter sensors wires are: red - 3.3v, black - GND, and yellow - Data

You need a 4.7K Ohm pull-up resistor between V+ and Data.
Here’s a nice article explaining pull-up (and pull-down) resistors:
[link](https://medium.freecodecamp.com/a-simple-explanation-of-pull-down-and-pull-up-resistors-660b308f116a#.snle4oxrl)

We will need to enable the OneWire protocol by following the
[Advanced Config instructions](https://hexdocs.pm/nerves/advanced-configuration.html#overwriting-files-in-the-boot-partition)
to get a custom version for fwup.conf from the rpi3 system in `deps\nerves\_system\_rpi3`
This will in turn allow use of a custom config.txt where we can uncomment this line:
`dtoverlay=w1-gpio-pullup,gpiopin=4`

## Twitter
We are using the Twitter client library [ExTwitter](https://github.com/parroty/extwitter)
([docs](http://hexdocs.pm/extwitter))

> The :consumer\_key, :consumer\_secret, :access\_token, and :access\_token\_secret have been 
shared in the NPP Outline Document or you can email me for them directly. You can hard-code them
in config.exs or preferably export them to your environment.

Feel free to play around with pattern matching in
[`pick_saying/1`](https://github.com/johnkacz/npp_weather_bot/blob/master/lib/npp_weather_bot/tweet.ex#L19)
and make your own sayings for your station.  Also make sure you have your correct station number in config.exs

## WeatherServer
WeatherServer is a GenServer that simply calls into the Tweet module, but this allows us
to supervise it in our main application so it can be restarted if it ever crashes

## Scheduling