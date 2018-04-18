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
      10.times do
        @game.complete_turn([0, 0])
      end

      @game
        .render_total_score(@test_renderer)
        .must_equal 0
    end
  end

  describe 'complete_turning ones' do
    it 'should calculate the total score as 20' do
      10.times do
        @game.complete_turn([1, 1])
      end

      @game
        .render_total_score(@test_renderer)
        .must_equal 20
    end
  end

  describe 'complete_turning a spare, then one, then zero' do
    it 'should calculate the total score as 12' do
      @game.complete_turn([5, 5]).complete_turn([1, 0])

      @game
        .render_total_score(@test_renderer)
        .must_equal 12
    end
  end

  describe 'complete_turning two spares and the rest' do
    it 'should calculate the total score as 27' do
      @game
        .complete_turn([6, 4])
        .complete_turn([5, 5])
        .complete_turn([1, 0])

      @game
        .render_total_score(@test_renderer)
        .must_equal 27
    end
  end

  describe 'complete_turning a strike' do
    it 'should calculate the total score as 10' do
      @game.complete_turn([10])

      @game
        .render_total_score(@test_renderer)
        .must_equal 10
    end
  end
end
