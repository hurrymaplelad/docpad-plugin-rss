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
    default:
      collection: 'posts'
      url: '/rss.xml' # optional, this is the default
```

RSS feed is written to `<outPath>/<url>`, `/rss.xml` by default.

## Compilation and Testing

```
git clone https://github.com/bevry/docpad
cd docpad
npm install
cake compile
npm link
cd ..

git clone https://github.com/hurrymaplelad/docpad-plugin-rss
cd docpad-plugin-rss
npm install
npm link docpad
cake test
```
