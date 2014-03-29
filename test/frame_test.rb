require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/frame'
require_relative 'minitest_helper'

describe Frame do
    let(:strike_roll) { 10 }
    let(:any_roll) { (0..10).to_a.sample }

    let(:invalid_roll_too_many) { 15 }
    let(:invalid_roll_less_than_zero) { -1 }

    let(:non_strike_roll) { (0..9).to_a.sample }
    let(:non_strike_spare_roll) { 10 - non_strike_roll }
    let(:non_strike_non_spare_roll) { non_strike_spare_roll - 1 }


    before do
      @frame = Frame.new
    end

    describe 'a new frame' do
      it 'should be in normal game mode' do
        @frame.mode.must_equal 'normal'
      end
      it 'should have no rolls' do
        @frame.rolls.must_equal []
      end
      it 'should not be able to calculate its score' do
        @frame.score.must_equal nil
      end
    end

    describe 'the first roll' do
      it 'should ignore a roll below zero' do
        @frame.register_roll invalid_roll_less_than_zero
        @frame.rolls.must_equal []
      end
      it 'should ignore a roll above maximum pins available' do
        @frame.register_roll invalid_roll_too_many
        @frame.rolls.must_equal []
      end

      describe 'a strike roll' do
        before do
          @frame.register_roll strike_roll
        end
        it 'should register the roll' do
          @frame.rolls.must_equal [strike_roll]
        end
        it 'should change to bonus mode' do
          @frame.mode.must_equal 'bonus'
        end
        it 'should not be able to calculate its score' do
          @frame.score.must_be_nil
        end
      end

      describe 'a non strike' do
        before do
          @frame.register_roll non_strike_roll
        end
        it 'should register the roll' do
          @frame.rolls.must_equal [non_strike_roll]
        end
        it 'should stay in normal mode' do
          @frame.mode.must_equal 'normal'
        end
        it 'should not be able to calculate its score' do
          @frame.score.must_be_nil
        end
      end
    end

    describe 'the second roll' do
      it 'should ignore a roll below zero' do
        @frame.register_roll any_roll
        @frame.register_roll invalid_roll_less_than_zero
        @frame.rolls.must_equal [any_roll]
      end

      describe 'after a strike' do
        before do
          @frame.register_roll strike_roll
        end
        it 'should ignore a roll above maximum pins available' do
          @frame.register_roll invalid_roll_too_many
          @frame.rolls.must_equal [strike_roll]
        end

        describe 'a strike roll' do
          before do
            @frame.register_roll strike_roll
          end
          it 'should register the roll' do
            @frame.rolls.must_equal [strike_roll, strike_roll]
          end
          it 'should stay in bonus mode' do
            @frame.mode.must_equal 'bonus'
          end
          it 'should not be able to calculate its score' do
            @frame.score.must_be_nil
          end
        end

        describe 'non strike roll' do
          before do
            @frame.register_roll non_strike_roll
          end
          it 'should register the roll' do
            @frame.rolls.must_equal [strike_roll, non_strike_roll]
          end
          it 'should stay in bonus mode' do
            @frame.mode.must_equal 'bonus'
          end
          it 'should not be able to calculate its score' do
            @frame.score.must_be_nil
          end
        end
      end

      describe 'after a non strike' do
        before do
          @frame.register_roll non_strike_roll
        end
        it 'should ignore a roll below zero' do
          @frame.register_roll invalid_roll_less_than_zero
          @frame.rolls.must_equal [non_strike_roll]
        end
        it 'should ignore a roll above maximum pins available' do
          @frame.register_roll non_strike_spare_roll + 1
          @frame.rolls.must_equal [non_strike_roll]
        end

        describe 'roll a spare' do
          before do
            @frame.register_roll non_strike_spare_roll
          end
          it 'should register the roll' do
            @frame.rolls.must_equal [non_strike_roll, non_strike_spare_roll]
          end
          it 'should change to bonus mode' do
            @frame.mode.must_equal 'bonus'
          end
          it 'should not be able to calculate its score' do
            @frame.score.must_be_nil
          end
        end

        describe 'roll a non spare' do
          before do
            @frame.register_roll non_strike_non_spare_roll
          end
          it 'should register the roll' do
            @frame.rolls.must_equal [non_strike_roll, non_strike_non_spare_roll]
          end
          it 'should change to complete mode' do
            @frame.mode.must_equal 'complete'
          end
          it 'should be able to calculate its score' do
            @frame.score.must_equal non_strike_roll + non_strike_non_spare_roll
          end
          it 'should not accept any more rolls' do
            @frame.register_roll any_roll
            @frame.rolls.must_equal [non_strike_roll, non_strike_non_spare_roll]
          end
        end
      end
    end

    describe 'the third roll' do

      describe 'after a second strike' do
        before do
          @frame.register_roll strike_roll
          @frame.register_roll strike_roll
        end
        it 'should ignore a roll below zero' do
          @frame.register_roll invalid_roll_less_than_zero
          @frame.rolls.must_equal [strike_roll, strike_roll]
        end
        it 'should ignore a roll above maximum pins available' do
          @frame.register_roll invalid_roll_too_many
          @frame.rolls.must_equal [strike_roll, strike_roll]
        end

        describe 'a strike roll' do
          before do
            @frame.register_roll strike_roll
          end
          it 'should register a valid roll' do
            @frame.rolls.must_equal [strike_roll,strike_roll,strike_roll]
          end
          it 'should change to completed mode' do
            @frame.mode.must_equal 'complete'
          end
          it 'should be able to calculate its score' do
            @frame.score.must_equal strike_roll + strike_roll + strike_roll
          end
        end
      end

      describe 'after a spare' do
        before do
          @frame.register_roll non_strike_roll
          @frame.register_roll non_strike_spare_roll
        end
        it 'should ignore a roll below zero' do
          @frame.register_roll invalid_roll_less_than_zero
          @frame.rolls.must_equal [non_strike_roll, non_strike_spare_roll]
        end
        it 'should ignore a roll above maximum pins available' do
          @frame.register_roll invalid_roll_too_many
          @frame.rolls.must_equal [non_strike_roll, non_strike_spare_roll]
        end

        describe 'any valid roll'do
          before do
            @frame.register_roll any_roll
          end
          it 'should register the roll' do
            @frame.rolls.must_equal [non_strike_roll,non_strike_spare_roll,any_roll]
          end
          it 'should change to completed mode' do
            @frame.mode.must_equal 'complete'
          end
          it 'should be able to calculate its score' do
            @frame.score.must_equal non_strike_roll + non_strike_spare_roll + any_roll
          end
        end
      end

      describe 'after a non spare' do
        before do
          @frame.register_roll non_strike_roll
          @frame.register_roll non_strike_non_spare_roll
        end
        it 'should not register any further rolls' do
          @frame.register_roll any_roll
          @frame.rolls.must_equal [non_strike_roll,non_strike_non_spare_roll]
        end
        it 'should stay as complete mode' do
          @frame.register_roll any_roll
          @frame.mode.must_equal 'complete'
        end
      end
    end

end
