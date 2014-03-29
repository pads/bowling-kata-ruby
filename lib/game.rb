require_relative 'frame'

class Game
  attr_accessor :frames

   def initialize
     self.frames = []
     (1..10).each do
       self.frames << Frame.new
     end
   end

   def bowl roll
     frames.each do |frame|
       if frame.mode == :bonus
         frame.register_roll roll
       end
       if frame.mode == :normal
         frame.register_roll roll
         break
       end
     end
   end

  def score
    score = 0
    frames.each do |frame|
      score += frame.score
    end
    score
  end
end
