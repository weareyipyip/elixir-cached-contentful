# Cached Contentful!

### Dependencies used

* [Contentful Delivery SDK](https://github.com/contentful-labs/contentful.ex)

### Installation

Add cached_contentful to your dependency list
``` Elixir
{:cached_contentful, git: "https://github.com/weareyipyip/CachedContentful.git",  tag: "0.1.1"}
```
### Configuration

Do some configuration
``` Elixir
config :cached_contentful,
    space_id: "YOUR_SPACE_ID",
    access_token: "YOUR_ACCESS_TOKEN",
    auto_update: false,
    update_interval: 24 * 60 * 60 * 1000 # Refresh every 24 hours (milliseconds)
```

* `spaceid` = Is the contentful space id that you want to use (REQUIRED)
* `access_token` = Token that matches the space (REQUIRED)
* `auto_update` = Set if you want the entries to be automatically updated via the worker.
* `update_interval` = Interval for updating the entries (OPTIONAL)

### Usage

To fetch the entries:

``` Elixir
CachedContentful.ContentfulRegistry.getEntries()
```

To update the entries manually:
``` Elixir
CachedContentful.ContentfulRegistry.updateEntries()
```