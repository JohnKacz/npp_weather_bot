use Mix.Config

config :nerves, :firmware,
  fwup_conf: "config/rpi3/fwup.conf"

config :npp_weather_bot, :wlan0,
  ssid: "BasicACUwifi",
  key_mgmt: :NONE

# Use these settings instead if you are running an a different wireless network
# config :npp_weather_bot, :wlan0,
#   ssid: "my_accesspoint_name",
#   key_mgmt: :"WPA-PSK",
#   psk: "secret"

# Each participant will have a station number assigned
config :npp_weather_bot, :station, "Station0"

# Be sure to set these with `export VAR=value` before compiling
config :extwitter, :oauth, [
   consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
   consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
   access_token: System.get_env("TWITTER_ACCESS_TOKEN"),
   access_token_secret: System.get_env("TWITTER_ACCESS_SECRET")
]
