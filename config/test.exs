import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :takso, TaksoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4001],
  secret_key_base: "test_secret_key_base_for_testing_purposes_only",
  server: true

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Configure test database
config :takso, Takso.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "takso_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We use a file-based cache for testing
# config :takso, TaksoWeb.Endpoint,
#   cache_static_manifest: "priv/static/cache_manifest.json"

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Disable telemetry during tests
config :phoenix, :telemetry_level, :debug

# Configure Hound
config :hound, driver: "chrome_driver", port: 55591
config :takso, sql_sandbox: true
