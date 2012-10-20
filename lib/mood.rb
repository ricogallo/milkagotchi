# encoding: UTF-8
class Mood
  def self.from attributes
    if attributes.all? { |key, value| value >= 3 }
      new("◕‿◕")
    elsif attributes.one? { |key, value| value < 3 }
      new("ఠ﹏ఠ")
    else
      new("ಠ︵ಠ")
    end
  end
  
  def initialize emoji
    @emoji = emoji
  end
  
  def to_s
    @emoji.to_s
  end
end