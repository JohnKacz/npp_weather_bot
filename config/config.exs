use Mix.Config

config :npp_weather_bot, :wlan0,
  ssid: "BasicACUwifi",
  key_mgmt: :NONE

# Use these settings instead if you are running an a different wireless network
# config :npp_weather_bot, :wlan0,
#   ssid: "my_accesspoint_name",
#   key_mgmt: :"WPA-PSK",
#   psk: "secret"