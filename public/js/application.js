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
        var audio, index, message, repo, username, _ref,
          _this = this;
        index = this.data.index;
        _ref = [this.data.commit.author.username, this.data.repository.name], username = _ref[0], repo = _ref[1];
        message = "" + username + " committed to " + repo;
        audio = function() {
          $('div#audio').append("<audio src='" + _this.data.sound_url + "' autoplay controls></audio>");
          return $('audio').on('ended', function(event) {
            var encoded, iframe, parent, remove_iframe, self, translate;
            self = $(this);
            parent = self.parent();
            encoded = encodeURIComponent(message.replace(/_/g, ' '));
            translate = "http://translate.google.com/translate_tts?q=" + encoded;
            iframe = $("<iframe src='" + translate + "'></iframe>").appendTo(parent);
            remove_iframe = function() {
              return iframe.remove();
            };
            return _.delay(remove_iframe, 10000);
          }).on('ended', function(event) {
            return $(this).remove();
          });
        };
        _.delay(audio, index * 350);
        return $('div#message').html(message);
      }
    });
  });

}).call(this);
