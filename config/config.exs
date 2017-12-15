# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

 # config :cached_contentful,
 #    space_id: "spaceid",
 #    access_token: "accesstoken",
 #    auto_update: false,
 #    update_interval: 24 * 60 * 60 * 1000 # Refresh every 24 hours (milliseconds)

 # Cached Contentful
 # config :cached_contentful,
 #    space_id: "xiextqhu1w2p",
 #    access_token: "97de787940255508c15687ffa6e93c971edc5b957ad5e8bd2f19ae788246d4a0",
 #    default_language: "nl",
 #    auto_update: false,
 #    update_interval: 24 * 60 * 60 * 1000 # Refresh every 24 hours (milliseconds)

 # config :cached_contentful,
 #    space_id: "jgohsybkmmf9",
 #    access_token: "ac7ead6389f92cfbde38e1b665374d489077029b4583140f77b91551d2ec8912",
 #    default_language: "nl",
 #    auto_update: false,
 #    update_interval: 24 * 60 * 60 * 1000 # Refresh every 24 hours (milliseconds)

 # Cached Contentful Prod
config :cached_contentful,
  space_id: "9jtlyow8hyvx",
  access_token: "845af55993560e0ff27ceb4035ca2f8bd6e52188ddd12d5edadb2232baadd9cb",
  default_language: "nl",
  auto_update: true,
  update_interval: 10 * 60 * 1000 # Refresh every 10 minute (milliseconds)