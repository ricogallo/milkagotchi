module MilkagotchiSchedules
  SCHEDULER = Milkagotchi.config.scheduler
  
  def automatically_reduce(time_table={})
    time_table.each do |attribute, time|
      SCHEDULER.every time, tags: self.id do |job|
        if self[attribute] < 1
          job.unschedule
        else
          self[attribute] -= 1
          if self.save!
            Pusher["chicks"].trigger("#{self.id}-changed", {}.to_json)
          end
        end
      end
    end
  end
  
  def unschedule_jobs
    jobs = SCHEDULER.find_by_tag(self.id)
    jobs.each do |job|
      job.unschedule
    end
  end
end