module MilkagotchiScheduler
  def automatically_reduce(chick, time_table={})
    time_table.each do |attribute, time|
      reduce_an_attribute_every(chick, attribute, time)
    end
  end
  
  def unschedule_jobs_for(chick)
    jobs = find_by_tag(chick.id)
    jobs.each do |job|
      job.unschedule
    end
  end
  
  private
  def reduce_an_attribute_every(chick, attribute, time)
    every time, tags: chick.id do |job|
      if chick[attribute] < 1
        job.unschedule
      else
        chick[attribute] -= 1
        if chick.save!
          Pusher["chicks"].trigger("#{chick.id}-changed", {})
        end
      end
    end
  end
end