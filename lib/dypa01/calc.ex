defmodule DYPA01.Calc do
  @moduledoc false

  @doc """
  Converts sensor signal to a distance in millimeters.

  ## Examples

      iex> distance_from_sensor_signal(<<255, 6, 216, 221>>)
      1752

  """
  @spec distance_from_sensor_signal(<<_::32>>) :: non_neg_integer()
  def distance_from_sensor_signal(<<0xFF, data_h, data_l, _crc>>) do
    data_h * 256 + data_l
  end
end
