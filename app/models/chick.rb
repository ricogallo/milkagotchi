class Chick
  include Mongoid::Document
  field :name, type: String
  field :food, type: Integer, default: 3
  field :toilet, type: Integer, default: 3
  field :fun, type: Integer, default: 3
  field :milk, type: Integer, default: 0
  
  attr_accessible :name
  
  validates_presence_of :name
  validates :name, length: { within: 3..16 }, allow_blank: true
  validate :maximum_number_of_chicks, on: :create
  
  def as_json(options={})
    super options.merge(methods: :mood)
  end
  
  def mood
    Mood.from_attributes(mood_factors).to_s
  end
  
  protected
  def mood_factors
    return food, toilet, fun
  end
  
  def maximum_number_of_chicks
    if Chick.count >= 5
      errors.clear
      errors[:base] << "Upgrade today your account and spawn MOAR chicks!"
    end
  end
end