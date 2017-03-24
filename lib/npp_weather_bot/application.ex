defmodule NPPWeatherBot.Application do
  use Application

  @interface :wlan0
  @kernel_modules Mix.Project.config[:kernel_modules]

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Task, [fn -> init_kernel_modules() end], restart: :transient, id: Nerves.Init.KernelModules),
      worker(Task, [fn -> init_network() end], restart: :transient, id: Nerves.Init.Network),
      worker(NPPWeatherBot.WeatherServer, [])
    ]

    opts = [strategy: :one_for_one, name: NPPWeatherBot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def init_kernel_modules() do
    Enum.each(@kernel_modules, & System.cmd("modprobe", [&1]))
  end

  def init_network() do
    opts = Application.get_env(:npp_weather_bot, @interface)
    Nerves.InterimWiFi.setup(@interface, opts)
    :timer.sleep(10_000)
    init_time()
  end

  def init_time() do
    IO.puts System.os_time(:second)
    System.cmd("ntpd", ["-q", "-p", "pool.ntp.org"])
    :timer.sleep(5_000)
    IO.puts System.os_time(:second)
  end
end
