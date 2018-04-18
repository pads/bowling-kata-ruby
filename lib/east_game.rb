class EastGame
  def initialize
    @score = 0
    @frames = []
  end

  def complete_turn(rolls)
    @frames << rolls
    self
  end

  def render_total_score(renderer)
    renderer.render_total_score(calculate_score)
  end

  private

  def calculate_score
    @frames.each_with_index do |rolls, index|
      if index > 0 && @frames[index - 1].inject(0){|sum,x| sum + x } == 10
        @score += rolls[0]
      end

      @score += rolls[0]

      # Strike!
      @score += rolls[1] if rolls[1]
    end
    @score
  end
end
