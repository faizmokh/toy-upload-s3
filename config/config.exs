# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :toy_upload_s3,
  ecto_repos: [ToyUploadS3.Repo]

# Configures the endpoint
config :toy_upload_s3, ToyUploadS3.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "AObf1i+z1FxFD1RX5DkZ8S96UT0BBzEcYqeXKhkiEdupu0FlpTE8ze2oUxKzRBB7",
  render_errors: [view: ToyUploadS3.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ToyUploadS3.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure AWS
config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role],
  s3: [
    scheme: "https://",
    host: "s3-toy-phoenix.s3-ap-southeast-1.amazonaws.com",
    region: "ap-southeast-1"
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
