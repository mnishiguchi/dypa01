defmodule DYPA01.PortRegistry do
  @moduledoc false

  @spec child_spec(any) :: Supervisor.child_spec()
  def child_spec(_args) do
    Supervisor.child_spec(
      Registry,
      id: __MODULE__,
      start: {__MODULE__, :start_link, []}
    )
  end

  @spec start_link :: {:error, any} | {:ok, pid}
  def start_link() do
    Registry.start_link(keys: :unique, name: __MODULE__)
  end

  @doc """
  Returns a via tuple for accessing a process that is held in this registry.

  ## Examples

      iex> PortRegistry.via("ttyAMA0")
      {:via, Registry, {DYPA01.PortRegistry, "ttyAMA0"}}

  """
  @spec via(binary) :: {:via, Registry, {DYPA01.PortRegistry, binary}}
  def via(port_name) when is_binary(port_name) do
    {:via, Registry, {__MODULE__, port_name}}
  end

  @spec whereis_name(binary) :: :undefined | pid
  def whereis_name(port_name) when is_binary(port_name) do
    Registry.whereis_name({__MODULE__, port_name})
  end

  @spec keys(pid) :: [binary]
  def keys(pid) when is_pid(pid) do
    Registry.keys(__MODULE__, pid)
  end
end
