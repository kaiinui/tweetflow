# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $.getJSON "/tweets/search", (tweets)->
    $el = $("._tweetflow")
    j = 0
    setInterval ->
      $("._tweet").remove() if j = 0
      i = 0
      j += 1
      tws = tweets.slice(20*(j-1), 20*j-1)
      for tweet in tws
        color = ["white", "white", "white", "white", "white", "white", "white", "white", "white", "white", "white", "green", "green", "blue", "red"].sample()
        size = [14, 15,  16, 18, 20, 24].sample()
        $("<span />").addClass("_tweet _#{tweet.length}").text(tweet).css("top", i * 29).css("left", i*40).css("color", color).css("font-size", size).appendTo $el
        i += 1
      j = 0 if j >= 5
    , 6000

Array.prototype.sample = ->
  this[Math.floor(Math.random() * this.length)]