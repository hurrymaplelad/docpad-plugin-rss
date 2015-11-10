# RSS Plugin for [DocPad](http://docpad.org)

<!-- BADGES/ -->

[![Build Status](https://img.shields.io/travis/hurrymaplelad/docpad-plugin-rss/master.svg)](http://travis-ci.org/hurrymaplelad/docpad-plugin-rss "Check this project's build status on TravisCI")
[![NPM version](https://img.shields.io/npm/v/docpad-plugin-rss.svg)](https://npmjs.org/package/docpad-plugin-rss "View this project on NPM")
[![Dependency Status](https://img.shields.io/david/hurrymaplelad/docpad-plugin-rss.svg)](https://david-dm.org/hurrymaplelad/docpad-plugin-rss)


<!-- /BADGES -->


<!-- DESCRIPTION/ -->

DocPad plugin that generates an RSS feed for a collection of documents

<!-- /DESCRIPTION -->


<!-- INSTALL/ -->

## Install

``` bash
docpad install rss
```

<!-- /INSTALL -->


## Usage

Configure a collection to feed in your [docpad configuration file](http://docpad.org/docs/config):

```coffee
plugins:
  rss:
    default:
      collection: 'posts'
      url: '/rss.xml' # optional, this is the default
      title: 'Your feed title' #optional, default to site title
```

RSS feed is written to `<outPath>/<url>`, `/rss.xml` by default.


<!-- CONTRIBUTE/ -->

## Contribute

[Discover how you can contribute by heading on over to the `CONTRIBUTING.md` file.](https://github.com/hurrymaplelad/docpad-plugin-rss/blob/master/CONTRIBUTING.md#files)

<!-- /CONTRIBUTE -->


<!-- BACKERS/ -->
## Contributors

These amazing people have contributed code to this project:

- [Eric Vantillard](http://github.com/evantill) <eric.vantillard@evaxion.fr> — [view contributions](https://github.com/hurrymaplelad/docpad-plugin-rss/commits?author=evantill)
- [varya](https://github.com/varya) — [view contributions](https://github.com/hurrymaplelad/docpad-plugin-rss/commits?author=varya)
- [nylnook](https://github.com/nylnook) — [view contributions](https://github.com/hurrymaplelad/docpad-plugin-rss/commits?author=nylnook)

[Become a contributor!](https://github.com/hurrymaplelad/docpad-plugin-rss/blob/master/CONTRIBUTING.md#files)

<!-- /BACKERS -->


<!-- LICENSE/ -->

## License

Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT license](http://creativecommons.org/licenses/MIT/)

<!-- /LICENSE -->


