use Mix.Config

config :quantum, :npp_weather_bot,
  cron: [
    weather_test: [
      schedule: "* * * * *",
      task: {NPPWeatherBot.WeatherServer, :fake_report}
    ]
  ]

config :quantum,
  timezone: "America/Chicago",
  global?: true
