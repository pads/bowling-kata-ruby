require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/frame'
require_relative 'minitest_helper'

describe Frame do
    let(:strike) { 10 }
    let(:first_roll_non_strike) { 3 }
    let(:second_roll_non_spare) { 2 }
    let(:second_roll_spare) { 7 }
    let(:invalid_roll_too_many) { 15 }
    let(:invalid_roll_less_than_zero) { -1 }

    before do
      @frame = Frame.new
    end

    describe 'invalid rolls' do
      it 'should reject rolls over the maximum allowed amount' do
        @frame.roll(invalid_roll_too_many)
        @frame.rolls.size.must_equal 0
      end

      it 'should reject rolls under the minimum allowed amount' do
        @frame.roll(invalid_roll_less_than_zero)
        @frame.rolls.size.must_equal 0
      end
    end

    describe 'a strike frame' do

      before do
        @frame.roll strike
      end

      it 'should not calculate the score with no registered bonus rolls' do
        @frame.score.must_be_nil
      end

      it 'should register that it needs further rolls to calculate score after strike' do
        @frame.needs_more_rolls?.must_equal true
      end

      it 'should register that it needs 1 further roll to calculate score after strike and a bonus roll' do
        @frame.roll strike
        @frame.needs_more_rolls?.must_equal true
      end

      it 'should not accept any further rolls after max bonus rolls have been registered' do
        @frame.roll strike
        @frame.roll strike
        @frame.needs_more_rolls?.must_equal false
      end

      it 'should not calculate the score with one bonus roll' do
        @frame.roll strike
        @frame.score.must_be_nil
      end

      it 'should calculate the correct score when the bouns rolls have been rolled' do
        random_roll = (0..10).to_a.sample
        frame_score = strike + strike + random_roll
        @frame.roll strike
        @frame.roll random_roll
        @frame.score.must_equal frame_score
      end

    end

    describe 'a spare frame' do

    end

    describe 'a non bouns frame' do

      it 'should register a valid initial roll' do
        @frame.roll first_roll_non_strike
        @frame.rolls.size.must_equal 1
        @frame.rolls[0].must_equal first_roll_non_strike
      end

      it 'should register a valid second roll' do
        @frame.roll first_roll_non_strike
        @frame.roll second_roll_non_spare

        @frame.rolls.size.must_equal 2
        @frame.rolls[0].must_equal first_roll_non_strike
        @frame.rolls[1].must_equal second_roll_non_spare
      end

      it 'should not let you register any further rolls' do
        skip
      end

      it 'should reflect the correct score' do
        skip
        @frame.roll first_roll_non_strike
        @frame.roll second_roll_non_spare

      end

    end

  describe 'bowling a frame' do

    it 'should allow a second roll when not a strike on first roll' do
      skip
    end

    it 'should allow 2 bouns rolls when you strike' do
      skip
    end

    it 'should allow 1 bonus roll where you roll a spare' do
      skip
    end

    it 'should not allow bonus rolls if not a strike' do
      skip
    end

    it 'should not allow a bonus roll if not a spare' do
      skip
    end

  end

end
