class ChickObserver < Mongoid::Observer
  def before_validation(chick)
    game_chick = GameAttributes.new(chick)
    game_chick.timer_attributes.each do |key, value|
      chick[key] = 5 if value > 5
    end
  end
  
  def after_create(chick)
    scheduler.start_timers(chick)
  end
  
  def before_destroy(chick)
    scheduler.unschedule_timers_for(chick)
  end
  
  def after_update(chick) 
    scheduler.manage(chick)
    send_notification(chick)
  end
  
  protected
  def scheduler
    Milkagotchi::Application.config.scheduler
  end
  
  def send_notification(chick)
    Pusher["chicks"].trigger("chick-changed", chick)
  end
end
