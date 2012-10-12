class Chick
  SAD, MEH, HAPPY = 0, 1, 2
  
  include Mongoid::Document
  field :name, type: String
  field :food, type: Integer, default: 3
  field :toilet, type: Integer, default: 3
  field :fun, type: Integer, default: 2
  field :study, type: Integer, default: 0
  
  validates_presence_of :name
  
  def as_json(options={})
    super options.merge(methods: :mood)
  end
  
  def mood
    attributes = [food, toilet, fun]
    if attributes.all? { |value| value >= 3 }
      Chick::HAPPY
    elsif attributes.one? { |value| value < 3 }
      Chick::MEH
    else
      Chick::SAD
    end
  end
end
