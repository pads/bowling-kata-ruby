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
  end

  def register_roll roll
    if (roll_is_valid? roll) && @mode != :complete
      @rolls << roll
    end
    determine_mode
  end

  def roll_is_valid? roll
    if pins_hit_are_more_than_available_or_negative? roll
      return false
    elsif (frame_needs_a_second_roll?) && (pins_hit_are_more_than_remaining_pins? roll)
      return false
    end
    true
  end

  def determine_mode
    if strike? || spare?
      @mode = :bonus
    elsif two_rolls_hit_less_than_max_pins? || registered_max_rolls?
      @mode = :complete
    end
  end

  def strike?
    (@rolls.size==1 && @rolls[0]==10)
  end

  def spare?
    @rolls.size==2 && (@rolls[0] + @rolls[1] == 10)
  end

  def two_rolls_hit_less_than_max_pins?
    @rolls.size==2 && (@rolls[0] + @rolls[1] < 10)
  end

  def frame_needs_a_second_roll?
    @rolls.size==1 && @mode == :normal
  end

  def registered_max_rolls?
    rolls.size==3
  end

  def pins_hit_are_more_than_available_or_negative? roll
    (roll < 0 || roll > 10)
  end

  def pins_hit_are_more_than_remaining_pins? roll
    (roll > 0 && roll > (10 - rolls[0]))
  end

  private :pins_hit_are_more_than_available_or_negative?, :frame_needs_a_second_roll?,
          :pins_hit_are_more_than_remaining_pins?

end
