class GameAction
  attr_reader :chick
  
  def initialize id, action
    @action = action
    @chick =  Chick.find(id)
  end
  
  def run
    @operations = Settings.game_actions[action]
    chick.update_attributes!(generate_attributes) if @operations
    chick
  end
  
  private
  def generate_attributes
    new_attributes = {}
    @operations.each do |key, value|
      new_attributes[key] = chick[key] + value if chick[key]
    end
    new_attributes
  end
end