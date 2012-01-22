zappa.run ->
  @connect()

  @on welcome: ->
    console.log "welcome: #{@data.time}"

  @on newcommit: ->
      # play sound
      # play commit via google translate
      # show latest commit info
      index = @data.index
      audio = =>
        $('div#audio').append "<audio src='#{@data.sound_url}' autoplay controls></audio>"
        $('audio').on 'ended', (event) -> $(this).remove()
      _.delay(audio, index * 250)
      $('div#message').html "#{@data.commit.author.username} committed to #{@data.repository.name} <br/>"
