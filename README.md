# Elixir Cached Contentful!

A simple way to fetch data from Contentful and cache them to avoid over 9000 API requests!!
There are only basic functionalities for entries and assets. More features coming soon, so enjoy this for now.
If you want to contribute, do a pull request with an argument why it should be merged and we will determine if it's awesome enouh.

Cheers and enjoy!

### Dependencies

* [Poison](https://github.com/devinus/poison)
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

#### Entries

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
CachedContentful.Api.updateEntries
```

#### Assets

Get all the assets:
``` Elixir
CachedContentful.Api.getAssets
```

Get asset by id
``` Elixir
CachedContentful.Api.getAssetById("s0m3l0n61D")
```

Update entries with fresh new data from the Contentful API:
``` Elixir
CachedContentful.Api.updateAssets
```