import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :resuelvefc, ResuelvefcWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "itK6yggDGY85vvEE0hwYuCkwm8p8U3xol0tXnkDvDgQzKIwG7AjR2UFpU7r+DCKW",
  server: false

# In test we don't send emails.
config :resuelvefc, Resuelvefc.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
