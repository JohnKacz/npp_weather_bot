defmodule NPPWeatherBot.WeatherServer do
  use GenServer

  def report() do
    GenServer.cast(:weather_server, {:report})
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
end
