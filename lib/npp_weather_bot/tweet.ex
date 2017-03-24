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
    seed = Enum.random(1..5)
    case {temp, seed} do
      {temp,_} when temp >= 100 -> "Wow it's #{temp}° right now! Let's go get ice cream! ##{@station}"
      {temp,_} when temp <= 32 -> "Brrr! It's #{temp}° outside. Stay warm out there. ##{@station}"
      {temp,1} -> "It's currently #{temp}° #ACUweather ##{@station}"
      {temp,2} -> "In other news the temperature outside is #{temp}° #ACUweather ##{@station}"
      {temp,3} -> "#{temp}° F in Abilene, TX ##{@station}"
      {temp,4} -> "Weather report for Abilene, TX: #{temp}° F ##{@station}"
      {temp,5} -> "Abilene, TX: #{temp}° F #ACUweather ##{@station}"
    end
  end
end