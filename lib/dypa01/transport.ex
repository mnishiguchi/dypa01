defmodule DYPA01.Transport do
  @moduledoc false

  @callback start_link(keyword) :: {:ok, pid} | {:error, any}
end
