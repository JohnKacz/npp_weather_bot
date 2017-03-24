defmodule NPPWeatherBot.TempReader do
  @moduledoc """
    Simple example to read temperature from DS18B20 temperature sensor
    For the longer sensors red - 3.3v, yellow - GND, and green - signal 
    For the short sensors  red - 3.3v, black - GND, and yellow - signal 
  """

  @base_dir "/sys/bus/w1/devices/"

  def get_temp(:f), do: get_temp() |> convert_to(:f) |> Float.round(2)
  def get_temp(:c), do: get_temp() |> Float.round(2)
  def get_temp(),   do: get_sensor() |> read_data |> parse_data

  def get_sensor() do
    File.ls!(@base_dir)
    |> Enum.filter(&(String.starts_with?(&1, "28-")))
    |> List.first
  end

  def read_data(sensor) do
    File.read!("#{@base_dir}#{sensor}/w1_slave")
  end

  def parse_data(sensor_data) do
    Regex.run(~r/t=(\d+)/, sensor_data)
    |> List.last
    |> String.to_integer
    |> (&(&1/1000)).()
  end

  def convert_to(temp, :f), do: (temp*9/5)+32
  def convert_to(temp, :c), do: (temp-32)*5/9
end