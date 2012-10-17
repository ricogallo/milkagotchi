class ChickObserver < Mongoid::Observer
  def after_create(chick)
    chick.automatically_reduce(Milkagotchi.config.chick_timers)
  end
  
  def before_destroy(chick)
    chick.unschedule_jobs
  end
end
