defmodule DYPA01.Measurement do
  @moduledoc """
  One sensor measurement
  """

  defstruct [:distance_mm, :timestamp_ms]

  @type t :: %{
          required(:timestamp_ms) => non_neg_integer(),
          required(:distance_mm) => number,
          optional(:__struct__) => atom
        }

  @spec from_sensor_signal(<<_::32>>) :: t()
  def from_sensor_signal(sensor_signal) do
    __struct__(
      distance_mm: DYPA01.Calc.distance_from_sensor_signal(sensor_signal),
      timestamp_ms: System.monotonic_time(:millisecond)
    )
  end
end
