module.exports = (BasePlugin) ->
  fs = require 'fs'
  RSS = require 'rss'

  class RssPlugin extends BasePlugin
    name: 'rss'

    config:
      default:
        collection: 'html'
        url: '/rss.xml'

    writeCollection: (configName,collectionConfig) ->
      {docpad} = @
      {site} = docpad.getTemplateData()
      feedCollection = docpad.getCollection collectionConfig.collection
      feedPath = docpad.getConfig().outPath + collectionConfig.url
      feed = new RSS
        title: site.title
        description: site.description
        site_url: site.url
        feed_url: site.url + collectionConfig.url
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
      docpad.log 'debug', "Wrote the RSS #{configName} xml file to: #{feedPath}"

    writeAfter: ->
      for own configName,collectionConfig of @getConfig()
        writeCollection configName,collectionConfig
