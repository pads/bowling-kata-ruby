class Frame
   attr_accessor :rolls, :mode

  def initialize
    @rolls = []
    @mode = :normal
  end

  def score
    if @mode == :complete
      return @rolls.reduce(:+)
    end
    nil
  end

  def register_roll roll
    if (roll_is_valid? roll) && @mode != :complete
      @rolls << roll
    end
    determine_mode
  end

  def roll_is_valid? roll
    if roll < 0 || roll > 10
      return false
    elsif @rolls.size==1 && @mode == :normal && roll > (10 - rolls[0])
      return false
    end
    true
  end

  def determine_mode
    if @rolls.size==1 && strike?
      @mode = :bonus
    elsif @rolls.size==2 && spare?
      @mode = :bonus
    elsif @rolls.size==2 && not_spare_or_strike?
      @mode = :complete
    elsif rolls.size==3
      @mode = :complete
    end
  end

  def strike?
    @rolls[0]==10
  end

  def spare?
    @rolls[0] + @rolls[1] == 10
  end

  def not_spare_or_strike?
    @rolls[0] + @rolls[1] < 10
  end

end
