defmodule NPPWeatherBot.WeatherServer do
  use GenServer

  def report() do
    GenServer.cast(:weather_server, {:report})
  end

  def fake_report() do
    GenServer.cast(:weather_server, {:fake_report})
  end

  ###
  # GenServer API
  ###

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: :weather_server)
  end

  def init() do
    {:ok, []}
  end

  def handle_cast({:report}, _) do
    NPPWeatherBot.Tweet.tweet_temp()
    {:noreply, []}
  end

  def handle_cast({:fake_report}, _) do
    NPPWeatherBot.Tweet.tweet("This is just a test...")
    {:noreply, []}
  end
end
