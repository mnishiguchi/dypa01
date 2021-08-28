defmodule DYPA01 do
  @moduledoc """
  Measure distance with DYP-A01 ultrasonic distance sensor.
  """

  use GenServer
  require Logger

  @type options() :: [GenServer.option() | {:port_name, String.t()}]

  @doc """
  Start a new GenServer for interacting with a DYPA01 sensor.

  ## Examples

      {:ok, pid} = DYPA01.start_link(port_name: "ttyAMA0")

  """
  @spec start_link(options()) :: GenServer.on_start()
  def start_link(init_arg \\ []) do
    gen_server_opts =
      Keyword.take(init_arg, [:name, :debug, :timeout, :spawn_opt, :hibernate_after])

    GenServer.start_link(__MODULE__, init_arg, gen_server_opts)
  end

  @doc """
  Measure the current distance.
  """
  @spec measure(GenServer.server()) :: {:ok, DYPA01.Measurement.t()} | {:error, any()}
  def measure(server) do
    GenServer.call(server, :measure)
  end

  @impl GenServer
  def init(opts) do
    port_name = Keyword.fetch!(opts, :port_name)

    :ok = Logger.info("[DYPA01] Starting on port #{inspect(port_name)}")

    transport =
      case DYPA01.Transport.start_link(port_name: port_name) do
        {:ok, transport} ->
          transport

        {:error, :eagain} ->
          DYPA01.Transport.find_pid(port_name)

        {:error, :enoent} ->
          raise("Port not found")

        {:error, :eacces} ->
          raise("Permission denied when opening port")

        {:error, other_reason} ->
          raise("Could not open port due to #{inspect(other_reason)}")
      end

    state = %{transport: transport, last_measurement: nil}

    {:ok, state}
  end

  @impl GenServer
  def handle_call(:measure, _from, state) do
    if state.last_measurement do
      {:reply, {:ok, state.last_measurement}, state}
    else
      {:reply, {:error, :no_measurement}, state}
    end
  end

  # The UART publishes a message with new data periodically.
  @impl GenServer
  def handle_info({:circuits_uart, _pid, sensor_signal}, state) do
    measurement = DYPA01.Measurement.from_sensor_signal(sensor_signal)
    {:noreply, %{state | last_measurement: measurement}}
  end
end
