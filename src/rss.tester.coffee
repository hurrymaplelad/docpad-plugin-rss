# Export Plugin Tester
module.exports = (testers) ->
  # Define Plugin Tester
  class RssTester extends testers.RendererTester
    # Configuration
    config:
      removeWhitespace: false
      contentRemoveRegex: /\<lastBuildDate\>.*\<\/lastBuildDate\>/g

    docpadConfig:
      templateData:
        site:
          url: 'http://my-site-url.com'
          title: 'site title'
          description: 'site description'
          author: 'eric.vantillard@evaxion.fr'
          date: new Date('Mon, 27 Jan 2014 13:01:00 GMT')
      plugins:
        rss:
          #must be compatible with previous version
          collection: 'html'
          url: '/rss.xml'
          default:
            item:
              date: (document) -> new Date('Mon, 27 Jan 2014 13:02:00 GMT')
          folder1:
            collection: 'folder1'
            url: '/rss-folder1.xml'
            maxItems: 2
            channel:
              title: (templateData) -> templateData.site.title
              description: (templateData) -> templateData.site.description
              pubDate: (templateData) -> templateData.site.date
            item:
              description: (document) -> document.contentRendered
              date: (document) -> new Date(document.meta.itemDate)
      collections:
        folder1: ->
          @getFiles(relativeOutDirPath: $startsWith: 'folder1',[itemDate: -1])
      enabledPlugins:
        'marked': true
        'eco': true
      #logLevel: 6 #7 for debug