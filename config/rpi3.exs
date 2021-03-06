use Mix.Config

# Be sure to set your hours based the assigned ones for your station
config :quantum, :npp_weather_bot,
  cron: [
    weather_report: [
      schedule: "* * * * *",
      task: {NPPWeatherBot.WeatherServer, :report}
    ]
  ]

config :quantum,
  timezone: "America/Chicago",
  global?: true
