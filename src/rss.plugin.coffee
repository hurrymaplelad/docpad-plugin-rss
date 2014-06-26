module.exports = (BasePlugin) ->
  fs = require 'fs'
  RSS = require 'rss'
  extendr = require 'extendr'

  class RssPlugin extends BasePlugin
    name: 'rss'

    config:
      default:
        collection: 'html'
        url: '/rss.xml'
        maxItems: 10
        channel:
          title: (templateData) -> templateData.site.title
          description: (templateData) -> templateData.site.description
          pubDate: (templateData) -> templateData.site.date
          author: (templateData) -> templateData.site.author
        item:
          title: (document) -> document.title
          description: (document) -> document.contentRenderedWithoutLayouts
          date: (document) -> document.date
          author: (document) -> document.author

    ###
    manage compatibility with previous versions of the plugins
    TODO remove when deprecated
    ###
    fixOldConfigurationFormat = (config) ->
      if config.collection? or config.url?
        #be compatible with previous version
        config.default.collection = config.collection or 'html'
        delete config.collection
        config.default.url = config.url or '/rss.xml'
        delete config.url
        newFormatDescription =  """
                                plugins:
                                \trss:
                                \t\tdefault:
                                \t\t\tcollection: '#{config.default.collection}'
                                \t\t\turl: '#{config.default.url}'
                                """
        @docpad.log('warn','docpad-plugin-rss configuration format has changed see the README.md for more informations')
        @docpad.log('warn', "docpad-plugin-rss configuration must be changed to #{newFormatDescription}")
      return config

    ###
    Use the default collection configuration
    to fill default options into all configured collections
    ###
    completeMissingHelpers = (config) ->
      defaultConfig = config.default
      for own name,collectionCnf of config when name isnt 'default'
        config[name]=extendr.deepClone(defaultConfig,collectionCnf)
      return config

    getConfig: ->
      config = super()
      config = fixOldConfigurationFormat(config)
      config = completeMissingHelpers(config)
      return config

    writeCollection = (configName,collectionConfig,next) ->
      # Prepare
      docpad = @docpad
      docpadConfig = docpad.getConfig()
      templateData = docpad.getTemplateData()

      # Extract informations
      {site} = templateData
      {outPath} = docpadConfig
      # Configurable helpers
      channelHelpers = collectionConfig.channel
      # Create feed
      feedCollection = docpad.getCollection collectionConfig.collection
      feedPath = outPath + collectionConfig.url
      feed = undefined
      try
        feed = new RSS
          title: channelHelpers.title(templateData)
          description: channelHelpers.description(templateData)
          site_url: site.url
          feed_url: site.url + collectionConfig.url
          author: channelHelpers.author(templateData)
          pubDate: channelHelpers.pubDate(templateData).toISOString()
      catch error
        docpad.log 'error', "Error while creating rss channel #{configName}: #{error}"
        return next(error)

      # Extract informations
      {maxItems} = collectionConfig
      # Configurable helpers
      itemHelpers = collectionConfig.item
      # Create items
      feedCollection.first(maxItems).forEach (document) ->
        document = document.toJSON()
        try
          feed.item
            title: itemHelpers.title(document)
            author: itemHelpers.author(document)
            description: itemHelpers.description(document)
            url: site.url + document.url
            date: itemHelpers.date(document).toISOString()
        catch error
          docpad.log 'error', "Error while creating rss item for document #{document?.realtivePath} in channel #{configName}: #{error}"
          return next(error)

      fs.writeFileSync feedPath, feed.xml(true)
      docpad.log 'debug', "Wrote the RSS #{configName} xml file to: #{feedPath}"

    writeAfter: (opts,next) ->
      docpad = @docpad
      config = @getConfig()
      for own configName,collectionConfig of config
        try
          writeCollection(configName,collectionConfig,next)
        catch error
          docpad.log 'error', "Error while writing rss channel #{configName}: #{error}"
          return next(error)
      next()
