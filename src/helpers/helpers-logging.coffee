###! logging helpers ###

Utils = require '../utils/utils'
grunt = require 'grunt'
util  = require 'util'
to    = require 'to'



# Debug
module.exports.debug = debug = (value) ->
  console.log 'Context: ', @
  console.log('Value: ', value) unless Utils.isUndefined value
  console.log '-----------------------------------------------'

module.exports.expandJSON = expandJSON = (src) ->
  list = grunt.file.expand(src)
  json = JSON.stringify(list, null, 2)
  Utils.safeString(json)

module.exports.expandMapping = expandMapping = (src) ->
  list = Utils.expandMapping(src)
  yml = to.format.yaml.stringify(list)
  Utils.safeString(yml)

module.exports.expandYAML = expandYAML = (src) ->
  list = grunt.file.expand(src)
  yml = to.format.yaml.stringify(list)
  Utils.safeString(yml)

# Log
module.exports.log = log = (value) ->
  console.log value


module.exports.register = (Handlebars, options) ->

  Handlebars.registerHelper "debug", debug
  Handlebars.registerHelper "expandJSON", expandJSON
  Handlebars.registerHelper "expandMapping", expandMapping
  Handlebars.registerHelper "expandYAML", expandYAML
  Handlebars.registerHelper "log", log

  # {{inspect}}
  Handlebars.registerHelper "inspect", (obj, ext) ->
    if Utils.isUndefined(options.ext)
      ext = ".html"
    else
      ext = options.ext
    md = "``` " + "json" + "\n" + (util.inspect(obj, true, null)) + "\n```"
    html = '<pre class="json">' + '\n' + (util.inspect(obj, true, null)) +
      '\n</pre>'
    result = Utils.switchOutput(ext, md, html)
    Utils.safeString result


  @