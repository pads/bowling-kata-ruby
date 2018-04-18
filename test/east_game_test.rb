require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/east_game'
require_relative 'minitest_helper'
require_relative 'test_renderer'

describe EastGame do
  before do
    @game = EastGame.new
    @test_renderer = TestRenderer.new
  end

  describe 'the worst game' do
    it 'should calculate the total score as zero' do
      20.times do
        @game.roll(0)
      end

      @game
        .render_total_score(@test_renderer)
        .must_equal 0
    end
  end

  describe 'rolling ones' do
    it 'should calculate the total score as 20' do
      20.times do
        @game.roll(1)
      end

      @game
        .render_total_score(@test_renderer)
        .must_equal 20
    end
  end

  describe 'rolling a spare, then one, then all zeros' do
    it 'should calculate the total score as 12' do
      2.times do
        @game.roll(5)
      end

      @game.roll(1)

      17.times do
        @game.roll(0)
      end

      @game
        .render_total_score(@test_renderer)
        .must_equal 12
    end
  end
end
