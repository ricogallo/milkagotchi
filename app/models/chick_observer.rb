class ChickObserver < Mongoid::Observer
    def after_create(chick)
    scheduler.automatically_reduce(chick, Settings.chick_timers.to_hash)
  end
  
  def before_destroy(chick)
    scheduler.unschedule_jobs_for(chick)
  end
  
  private
  def scheduler
    Milkagotchi::Application.config.scheduler
  end
end
