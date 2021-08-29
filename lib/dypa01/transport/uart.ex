defmodule DYPA01.Transport.UART do
  @moduledoc false

  @behaviour DYPA01.Transport

  @uart_config [
    speed: 9600,
    data_bits: 8,
    stop_bits: 1,
    parity: :none,
    active: true,
    framing: Circuits.UART.Framing.FourByte
  ]

  @impl DYPA01.Transport
  def start_link(args) do
    port_name = Keyword.fetch!(args, :port_name)

    with {:ok, transport} <- Circuits.UART.start_link(),
         :ok <- Circuits.UART.open(transport, port_name, @uart_config) do
      {:ok, transport}
    end
  end
end
