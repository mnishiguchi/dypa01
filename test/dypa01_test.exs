defmodule DYPA01Test do
  # Do not use async bacause this involves many processes.
  use ExUnit.Case

  import Mox

  # https://hexdocs.pm/mox/Mox.html#module-global-mode
  setup :set_mox_from_context

  # https://hexdocs.pm/mox/Mox.html#verify_on_exit!/1
  setup :verify_on_exit!

  test "basic workflow" do
    DYPA01.MockTransport
    |> Mox.expect(:start_link, 1, fn [port_name: "ttyAMA0"] -> {:ok, fake_transport()} end)

    assert {:ok, pid} = DYPA01.start_link(port_name: "ttyAMA0")
    assert is_pid(pid)

    # Measurement is initially nil
    state = :sys.get_state(pid)
    assert %{last_measurement: nil, transport: _} = state
    assert DYPA01.measure(pid) == {:error, :no_measurement}

    # Stores the last measurement once receiving data from the device periodically
    :sys.replace_state(pid, fn state -> %{state | last_measurement: fake_measurement()} end)
    assert DYPA01.measure(pid) == {:ok, fake_measurement()}
  end

  defp fake_transport do
    :c.pid(0, 0, 0)
  end

  defp fake_measurement do
    %DYPA01.Measurement{
      distance_mm: 1680,
      timestamp_ms: 321_793
    }
  end
end
