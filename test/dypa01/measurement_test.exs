defmodule DYPA01.MeasurementTest do
  use ExUnit.Case, async: true

  test "from_sensor_signal" do
    sensor_signal = <<255, 6, 216, 221>>

    assert %DYPA01.Measurement{
             distance_mm: 1752,
             timestamp_ms: _
           } = DYPA01.Measurement.from_sensor_signal(sensor_signal)
  end
end
