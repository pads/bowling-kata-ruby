class Frame
   attr_accessor :rolls, :mode

  def initialize
    self.rolls = []
    self.mode = :normal
  end

  def score
    if self.mode == :complete
      return self.rolls.inject(:+)
    end
    nil
  end

  def register_roll roll
    if (roll_is_valid? roll) && self.mode != :complete
      rolls << roll
    end
    determine_mode
  end

  def roll_is_valid? roll
    if roll < 0 || roll > 10
      return false
    elsif rolls.size==1 && mode == :normal && roll > (10 - rolls[0])
      return false
    end
    true
  end

  def determine_mode

    if rolls.size==1 && rolls[0] ==10
      self.mode = :bonus
    elsif rolls.size==2 && rolls[0] + rolls[1] == 10
      self.mode = :bonus
    elsif rolls.size==2 && rolls[0] + rolls[1] < 10
      self.mode = :complete
    elsif rolls.size==3
      self.mode = :complete
    end

  end

end
