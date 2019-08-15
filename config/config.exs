# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :stock_tracker,
  ecto_repos: [StockTracker.Repo]

# Configures the endpoint
config :stock_tracker, StockTracker.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "y532QRt3rIk4A8fUqljQ/qiBL9vHnQsTk9ITKREYBqr/n+i4mEAXHE0cM2vwvy3p",
  render_errors: [view: StockTracker.ErrorView, accepts: ~w(json)],
  pubsub: [name: StockTracker.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
