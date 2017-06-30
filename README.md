# Elixir Cached Contentful!

### Dependencies used

* [Httpoison](https://github.com/edgurgel/httpoison)

### Installation

Add cached_contentful to your dependency list
``` Elixir
{:cached_contentful, git: "https://github.com/weareyipyip/elixir-cached-contentful.git"}
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

Get all the entries:
``` Elixir
CachedContentful.Api.getEntries
```

Get all entries by type
``` Elixir
CachedContentful.Api.getEntriesByType("entrytype")
```

Get entry by id
``` Elixir
CachedContentful.Api.getEntryById("s0m3l0n61D")
```

Update entries with fresh new data from the Contentful API:
``` Elixir
CachedContentful.Api.updateEntries()
```

### TODO

The dependency only contains basic functionalities for entries. will add media, space and more complex searches later.