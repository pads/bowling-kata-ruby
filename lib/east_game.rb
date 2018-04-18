class EastGame
  def initialize
    @score = 0
    @rolls = []
  end

  def roll(score)
    @rolls << score
    self
  end

  def render_total_score(renderer)
    renderer.render_total_score(calculate_score)
  end

  private

  def calculate_score
    @frames = @rolls.each_slice(2).to_a
    @frames.each_with_index do |frame, index|
      if index > 0 && @frames[index - 1].inject(0){|sum,x| sum + x } == 10
        @score += frame[0]
      end
      @score += frame[0] + frame[1]
    end
    @score
  end
end
