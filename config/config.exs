# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

 # config :cached_contentful,
 #    space_id: "spaceid",
 #    access_token: "accesstoken",
 #    auto_update: false,
 #    update_interval: 24 * 60 * 60 * 1000 # Refresh every 24 hours (milliseconds)

 # Cached Contentful
 config :cached_contentful,
    space_id: "xiextqhu1w2p",
    access_token: "97de787940255508c15687ffa6e93c971edc5b957ad5e8bd2f19ae788246d4a0",
    default_language: "en-US",
    auto_update: false,
    update_interval: 24 * 60 * 60 * 1000 # Refresh every 24 hours (milliseconds)
