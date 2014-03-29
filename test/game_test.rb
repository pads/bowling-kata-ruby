require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/game'
require_relative 'minitest_helper'

describe Game do
  let(:perfect_game_rolls) { [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10] }
  let(:perfect_game_score) { 300 }

  let(:worst_game_rolls) { [0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0] }
  let(:worst_game_score) { 0 }

  let(:all_spare_rolls) { [ 5,5, 7,3, 3,7, 5,5, 0,10, 9,1, 9,1, 1,9, 2,8, 6,4, 1] }
  let(:all_spare_score) { 143 }

  let(:random_game) { [10, 0,1, 4,2, 10, 9,0, 8,0, 0,0, 5,5, 4,2, 10,0,1 ] }
  let(:random_game_score) { 85 }

  before do
    @game = Game.new
  end

  describe 'a new game' do
    it 'should set up the correct amount of frames' do
      @game.frames.size.must_equal 10
    end
  end

  describe 'the perfect game' do
    before do
      perfect_game_rolls.each do |roll|
        @game.bowl roll
      end
    end

    it 'should calculate the correct score' do
      @game.score.must_equal perfect_game_score
    end
  end

  describe 'the worst game' do
    before do
      worst_game_rolls.each do |roll|
        @game.bowl roll
      end
    end

    it 'should calculate the correct score' do
      @game.score.must_equal worst_game_score
    end
  end

  describe 'the every frame is a spare' do
    before do
      all_spare_rolls.each do |roll|
        @game.bowl roll
      end
    end

    it 'should calculate the correct score' do
      @game.score.must_equal all_spare_score
    end
  end

  describe 'a random game' do
    before do
      random_game.each do |roll|
        @game.bowl roll
      end
    end

    it 'should calculate the correct score' do
      @game.score.must_equal random_game_score
    end
  end
end
