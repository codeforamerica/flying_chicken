require('zappa') ->
  @use 'bodyParser', 'methodOverride', @app.router, 'static'
  @enable 'default layout', 'serve jquery', 'serve sammy', 'minify'
  zap = this

  @configure
    development: => @use errorHandler: {dumpExceptions: on}
    production: => @use 'errorHandler'

  @get '/': -> @render 'index'

  @get '/posthook': ->
    # @params.id

    # parse github hook
    #
    # grab the yaml list
    #
    # emit

    zap.io.sockets.emit 'newcommit', {commit_name: "TEST NAME"}
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
      $('body').append "new commit: #{@data.commit_name}"

  @view index: ->
    @title = 'Coder Sounds'
    @scripts = ['/socket.io/socket.io', '/zappa/jquery',
        '/zappa/zappa', '/shared', '/index']

    h1 @title