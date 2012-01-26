# Object to store/update our list of repos 
# and subscribe/unsubscribe from Github's pubsubhubbub server
#
# Authentication: 
#    http://developer.github.com/v3/#authentication
# Repo List:
#    http://developer.github.com/v3/repos/
# Pubsubhubbub:
#    http://developer.github.com/v3/repos/hooks/#pubsubhubbub
#
request = require 'request'

class Repos

  constructor: (@config) ->
    # setup and make an initial fetch/subscribe of list of repos
    @list = []
    @refreshRepos()    
    
  #
  # Fetches the list of repositories and saves them to @list
  # Also subscribes to each one
  #
  refreshRepos: ->
    # Request the repo list      
    request "https://api.github.com/#{@config.github.type}s/#{@config.github.account}/repos?access_token=#{@config.github.access_token}", (error, res, body) =>
      fullRepos = JSON.parse(body)      
      
      newList = []
      
      for fullRepo in fullRepos
        newList.push fullRepo.name
      
      # Compare our new list to our old list
      # in case we want to push changes to the client
      deletedRepos = arraySubtract @list, newList
      addedRepos = arraySubtract newList, @list
      
      for addedRepo in addedRepos 
        # subscribe those repos!
        @subscribe(addedRepo)
      
      @list = newList
    
      console.log "Added #{addedRepos.length} repositories; deleted #{deletedRepos.length} repositories; #{@list.length} total repositories" 

  subscribe: (repo) ->
    postData = {
      "method" : "POST",
      "url"  : "https://api.github.com/hub?access_token=#{@config.github.access_token}",
      "form" : {
        "hub.mode" : "subscribe",
        "hub.callback" : "#{@config.base_url}/posthook",
        "hub.topic"    : "https://github.com/#{@config.github.account}/#{repo}/events/push",
      }
    }
    request postData, (error, res, body) =>
      # Empty body is success (oddly enough)
      if !body
        console.log "Subscribed to the '#{repo}' repository."
        # do nothing yet other than hope it worked
      else
        console.log "Subscription to '#{repo}' FAILED"

#
# Return the elements of arrayA - arrayB
# (so elements in A that are NOT in B
#
arraySubtract = (a, b) -> 
  a.filter( (i) -> !(b.indexOf(i) > -1) )

#### Exports
module.exports = Repos