window.Milkagotchi =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Notifiers: {}
  init: ->
    @notifier = new Milkagotchi.Notifiers.PusherNotifier($("#milkagotchi").data('pusherkey'))
    new Milkagotchi.Routers.Chicks()
    Backbone.history.start(pushState: true)

$(document).ready ->
  Pusher.log = (message) ->
    window.console.log message
  WEB_SOCKET_DEBUG = true;
  Milkagotchi.init()