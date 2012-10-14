module MilkagotchiSchedules
  def automatically_reduce(attribute, time)
    Milkagotchi.scheduler.every time, tags: "reduce:#{attribute}:#{self.id}" do |job|
      if self[attribute] < 1
        job.unschedule
      else
        self[attribute] -= 1
        self.save!
      end
    end
  end
end