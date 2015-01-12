module Bowling
  class Game

    def initialize
      @rolls = []
    end

    ALL_PINS_SCORE = 10
    
    def roll(pins)
      @rolls << pins
    end

    def score
      total_score = 0
      frame_index = 0
      10.times do 
        if is_spare?(frame_index)
          total_score += spare_score(frame_index)
          frame_index += 2
        elsif is_strike?(frame_index)
          total_score += strike_score(frame_index)
          frame_index += 1
        else
          total_score += @rolls[frame_index] + @rolls[frame_index + 1]
          frame_index += 2
        end
      end
      total_score
    end

    def strike_score(frame_index)
      ALL_PINS_SCORE + @rolls[frame_index + 1] + @rolls[frame_index + 2]
    end

    def spare_score(frame_index)
      ALL_PINS_SCORE + @rolls[frame_index + 2]
    end

    def is_strike?(frame_index)
      @rolls[frame_index] == ALL_PINS_SCORE
    end

    def is_spare?(frame_index)
      @rolls[frame_index] + @rolls[frame_index + 1] == ALL_PINS_SCORE
    end
  end
end

describe Bowling::Game do
  let(:game){Bowling::Game.new}

  it 'scores a gutter game' do
    roll_many(20, 0)
    expect(game.score).to be(0)
  end

  it 'scores all ones' do
    roll_many(20, 1)
    expect(game.score).to be(20)
  end
  
  it 'scores a spare' do
    game.roll(5)
    game.roll(5)
    game.roll(3)
    roll_many(17, 0)
    expect(game.score).to be(16)
  end

  it 'scores a strike' do
    game.roll(10)
    game.roll(3)
    game.roll(4)
    roll_many(17, 0)
    expect(game.score).to be(24)
  end

  it 'scores perfect game' do
    roll_many(12, 10)
    expect(game.score).to be(300)
  end

  def roll_many(number, pins)
    number.times do
      game.roll(pins)
    end
  end
end
