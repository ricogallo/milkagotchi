window.Milkagotchi =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Backbone.Routers.Milkagotchi()
    Backbone.history.start(pushState: true)

$(document).ready ->
  Milkagotchi.init()
