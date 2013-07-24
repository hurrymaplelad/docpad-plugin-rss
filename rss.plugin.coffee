module.exports = (BasePlugin) ->
  fs = require 'fs'
  RSS = require 'rss'

  class RssPlugin extends BasePlugin
    name: 'rss'

    config:
      collection: 'html'

    writeAfter: ->
      {docpad} = @
      {site} = docpad.getTemplateData()
      feedCollection = docpad.getCollection @config.collection
      feedPath = docpad.getConfig().outPath+'/rss.xml'
      feed = new RSS
        title: site.title
        description: site.description
        site_url: site.url
        feed_url: site.url + '/rss.xml'
        author: site.author
        pubDate: site.date.toISOString()

      feedCollection.first(10).forEach (document) ->
        document = document.toJSON()
        feed.item
          title: document.title
          author: document.author
          description: document.contentRenderedWithoutLayouts
          url: site.url + document.url
          date: document.date.toISOString()

      fs.writeFileSync feedPath, feed.xml(true)
      docpad.log 'debug', "Wrote the rss.xml file to: #{feedPath}"
