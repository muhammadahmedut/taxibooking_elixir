ExUnit.start()

# Configure Ecto for testing
Ecto.Adapters.SQL.Sandbox.mode(Takso.Repo, :manual)
