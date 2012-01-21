###
  Distributed Code for America coder sounds.

    $ coffee app.coffee
###

PORT = process.argv[2] or 3000

yamlish = require 'yamlish'
request = require 'request'
require('zappa') PORT, ->
  @use 'bodyParser', 'methodOverride', @app.router, 'static'
  # Cache static content for 10 minutes.
  @use @express.static "#{@root}/public", maxAge: 600000
  @enable 'serve jquery', 'serve sammy', 'minify'
  zap = this

  @configure
    development: => @use errorHandler: {dumpExceptions: on}
    production: => @use 'errorHandler'

  @get '/': ->
    @scripts = [
      '/socket.io/socket.io', 
      '/zappa/jquery',
      '/zappa/zappa',
      '/shared', '/index'
    ]
    @render layout: {title: 'Coder Sounds'}

  @post '/posthook': ->

    # parse github hook
    payload = JSON.parse(@.body.payload)

    console.log payload
    # grab the yaml list


    request "https://raw.github.com/codeforamerica/cfa_coder_sounds/master/list.yml" , (error, res, body) ->
        yaml_data = yamlish.decode(body);
        #console.log "yaml", yaml_data

        base_sound_url = "https://github.com/codeforamerica/cfa_coder_sounds/blob/master/sounds/"

        # emit
        zap.io.sockets.emit "newcommit", {commit:commit, repository:payload.repository, sound_url:base_sound_url+yaml_data.users[commit.author.username]+"?raw=true"} for commit in payload.commits
    @send 'ok'

  @on connection: ->
    @emit welcome: {time: new Date()}

  @client '/index.js': ->
    @connect()

    @on welcome: ->
      $('body').append "welcomed: #{@data.time}"

    @on newcommit: ->
        # play sound
        # play commit via google translate
        # show latest commit info
        $('div#audio').html "<audio src='#{@data.sound_url}' autoplay controls></audio>"
        $('div#message').html "#{@data.commit.author.username} committed to #{@data.repository.name} <br/>"
