# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

 config :cached_contentful,
    space_id: "spaceid",
    access_token: "accesstoken",
    environment: "master",
    auto_update: false,
    update_interval: 24 * 60 * 60 * 1000 # Refresh every 24 hours (milliseconds)