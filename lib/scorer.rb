class Scorer
  def total(game)
    self
  end

  def render_total_score(renderer)
    renderer.render_total_score(@total)
  end
end
