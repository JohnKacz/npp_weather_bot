defmodule NPPWeatherBot.Tweet do
  @moduledoc """
    Send Tweets to Twiiter using the ExTwitter client library 
  """
  @station Application.get_env(:npp_weather_bot, :station)
  
  def tweet_temp() do
    NPPWeatherBot.TempReader.get_temp(:f)
    |> pick_saying
    |> tweet
  end

  def tweet(text) do
    text
    |> IO.inspect
    |> ExTwitter.update
  end

  def pick_saying(temp) do

    cond do
      temp >= 120 -> "What is this? Death Valley? It's #{temp}° outside right now. ##{@station}"
      temp >= 100 -> "Wow it's #{temp}° right now! Let's go get ice cream! #ACUweather ##{@station}"
      temp >= 90 -> "Currently #{temp}° It's warming up. #ACUweather ##{@station}"
      temp >= 80 -> "In other news the temperature outside is #{temp}° #ACUweather ##{@station}"
      temp >= 65 -> "It's currently a pleasant #{temp}° F in Abilene, TX #ACUweather ##{@station}"
      temp >= 50 -> "Weather report for Abilene, TX: #{temp}° F #ACUweather ##{@station}"
      temp >= 40 -> "Abilene, TX: #{temp}° F #ACUweather ##{@station}"
      temp >= 32 -> "Brrr! It's #{temp}° outside. Stay warm out there. #ACUweather ##{@station}"
      temp < 32 -> "#{temp}° Good thing my circuits keep me warm. #ACUweather ##{@station}"
    end
  end
end