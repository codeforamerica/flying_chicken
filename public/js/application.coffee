zappa.run ->
  @connect()

  @on welcome: ->
    console.log "welcome: #{@data.time}"

  @on newcommit: ->
    # play sound
    # play commit via google translate
    index = @data.index
    [username, repo] = [@data.commit.author.username, @data.repository.name]
    message = "#{username} committed to #{repo}"
    audio = =>
      $('div#audio').append "<audio src='#{@data.sound_url}' autoplay controls></audio>"
      $('audio').on('playing', (event) ->
        self = $(this)
        parent = self.parent()
        encoded = encodeURIComponent(message.replace(/_/g, ' '))
        translate = "http://translate.google.com/translate_tts?q=#{encoded}"
        iframe = $("<iframe src='#{translate}'></iframe>").appendTo(parent)
        remove_iframe = -> iframe.remove()
        _.delay(remove_iframe, 10000)
      ).on('ended', (event) ->
        $(this).remove()
      )
    _.delay(audio, index * 350)
    # show latest commit info
    $('div#message').html message
