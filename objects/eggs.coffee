#
# Eggs are further posts of commits.  This makes
# it so that only one webhook is needed.
#

# Requires
request = require 'request'

# Eggs class
class Eggs

  constructor: (@config) ->
    # console.log 'Constructing...'

  throw_eggs: (payload) ->
    postDataTemplate = {
      "method" : "POST",
      "form": {
        "payload": JSON.stringify payload
      }
    }
	
    console.log payload

    # Go through eggs
    for name, egg of @config.eggs
      do -> 
        postData = postDataTemplate
        postData.url = egg
        request postData, (error, res, body) =>
          if true
            console.log error
            console.log "Egg delivered to '#{name}'."
            # do nothing yet other than hope it worked
          else
            console.log "Egg to '#{name}' (#{egg}) FAILED"

# Exports
module.exports = Eggs