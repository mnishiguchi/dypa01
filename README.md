# DYP-A01

[![Hex version](https://img.shields.io/hexpm/v/dypa01.svg 'Hex version')](https://hex.pm/packages/dypa01)
[![API docs](https://img.shields.io/hexpm/v/dypa01.svg?label=docs 'API docs')](https://hexdocs.pm/dypa01)
[![CI](https://github.com/mnishiguchi/dypa01/actions/workflows/ci.yml/badge.svg)](https://github.com/mnishiguchi/dypa01/actions/workflows/ci.yml)
[![Publish](https://github.com/mnishiguchi/dypa01/actions/workflows/publish.yml/badge.svg)](https://github.com/mnishiguchi/dypa01/actions/workflows/publish.yml)

Use [DYP-A01](https://www.adafruit.com/product/4664) ultrasonic distance sensor in Elixir.

## Usage

```elixir
# Discover serial ports in use
iex> Circuits.UART.enumerate
%{"ttyAMA0" => %{}}

# Start a gen server for interacting with a DYPA01 sensor
iex> {:ok, pid} = DYPA01.start_link(port_name: "ttyAMA0")
{:ok, #PID<0.1407.0>}

# Measure the current distance
iex> DYPA01.measure(pid)
{:ok, %DYPA01.Measurement{distance_mm: 1680, timestamp_ms: 321793}}
```
