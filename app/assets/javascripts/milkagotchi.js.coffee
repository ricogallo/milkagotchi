window.Milkagotchi =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Milkagotchi.Routers.Chicks()
    Backbone.history.start(pushState: true)

$(document).ready ->
  Milkagotchi.init()