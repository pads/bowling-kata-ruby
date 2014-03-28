class Frame
  attr_accessor :rolls

  def initialize
    self.rolls = []
  end

  def roll roll_amount
    if (roll_amount <= 10 && roll_amount >= 0) && self.needs_more_rolls?
      rolls << roll_amount
    end

  end

  def needs_more_rolls?
    if rolls.size == 0
      return true
    elsif rolls[0] == 10 && rolls.size < 3
      return true
    elsif rolls[0] < 10 && rolls.size == 1
      return true
    end
    false
  end

  def score
    if needs_more_rolls?
      return nil
    end
    self.rolls.inject(:+)
  end


end
