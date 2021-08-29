# Always warning as errors
if Version.match?(System.version(), "~> 1.10") do
  Code.put_compiler_option(:warnings_as_errors, true)
end

# Define dynamic mocks
Mox.defmock(DYPA01.MockTransport, for: DYPA01.Transport)

# Override the config settings
Application.put_env(:dypa01, :transport_mod, DYPA01.MockTransport)

ExUnit.start()
