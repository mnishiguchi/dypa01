defmodule DYPA01.Transport do
  @moduledoc false

  require Logger

  @uart_config [
    speed: 9600,
    data_bits: 8,
    stop_bits: 1,
    parity: :none,
    active: true
  ]

  @spec start_link(keyword) :: {:error, any} | {:ok, pid}
  def start_link(args \\ []) do
    port_name = Keyword.fetch!(args, :port_name)

    with {:ok, transport} <- Circuits.UART.start_link(),
         :ok <- Circuits.UART.open(transport, port_name, @uart_config) do
      {:ok, transport}
    end
  end

  @spec find_pid(binary) :: pid | nil
  def find_pid(port_name) do
    case Circuits.UART.find_pids() do
      [{pid, ^port_name}] -> pid
      _ -> nil
    end
  end
end
