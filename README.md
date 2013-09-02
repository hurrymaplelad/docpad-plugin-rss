# DocPad RSS Plugin
Generates an RSS feed for a collection of documents

## Getting Started

```
npm install --save docpad-plugin-rss
```

Configure a collection to feed in your `docpad.coffee`:

```coffee
plugins:
  rss:
    collection: 'posts'
    url: '/rss.xml' # optional, this is the default
```

RSS feed is written to `<outPath>/<url>`, `/rss.xml` by default.
