###
  Distributed Code for America coder sounds.

    $ coffee app.coffee
###
fs      = require 'fs'
request = require 'request'
yamlish = require 'yamlish'
zappa   = require 'zappa'

# Configuration
try
  config = yamlish.decode( fs.readFileSync(__dirname + "/config.yml").toString() )
catch error
  console.log error
  console.log "File config.yml not found."
  process.exit(1)

# Make sure that our config is properly setup (using config.yml or Heroku
config.github.access_token = process.env.GITHUB_ACCESS_TOKEN || config.github.access_token
if !config.github.access_token
  throw "You need to set an access token either in config.yml or 'heroku config:add GITHUB_ACCESS_TOKEN=#####'"

# instantiate our repos
repos = require './objects/repos'
repos = new repos config

PORT = process.argv[2] or 3000

zappa PORT, ->
  @use 'bodyParser'
  # Cache static content for 10 minutes.
  @use @express.static "#{@root}/public", maxAge: 600000
  zap = @

  @configure
    development: => @use errorHandler: {dumpExceptions: on}
    production: => @use 'errorHandler'

  @get '/': ->
    @render layout: {title: 'Coder Sounds'}

  @post '/posthook': ->

    # parse github hook
    payload = JSON.parse(@body.payload)
    console.log payload

    # grab the yaml list
    yaml_list = "https://raw.github.com/codeforamerica/cfa_coder_sounds/master/list.yml" 
    request yaml_list, (error, res, body) =>
        yaml_data = yamlish.decode(body)
        base_sound_url = "https://github.com/codeforamerica/cfa_coder_sounds/blob/master/sounds/"

        # emit
        for commit, index in payload.commits
          user_name = commit.author.username
          sound_url = base_sound_url + yaml_data.users[user_name] + "?raw=true"
          zap.io.sockets.emit "newcommit", {
            commit: commit,
            index: index,
            repository: payload.repository,
            sound_url: sound_url
          }
    @send 'ok'

  @on connection: ->
    @emit welcome: time: new Date()
