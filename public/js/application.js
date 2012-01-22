(function() {

  zappa.run(function() {
    this.connect();
    this.on({
      welcome: function() {
        return console.log("welcome: " + this.data.time);
      }
    });
    return this.on({
      newcommit: function() {
        var audio, index,
          _this = this;
        index = this.data.index;
        audio = function() {
          $('div#audio').append("<audio src='" + _this.data.sound_url + "' autoplay controls></audio>");
          return $('audio').on('ended', function(event) {
            return $(this).remove();
          });
        };
        _.delay(audio, index * 250);
        return $('div#message').html("" + this.data.commit.author.username + " committed to " + this.data.repository.name + " <br/>");
      }
    });
  });

}).call(this);
