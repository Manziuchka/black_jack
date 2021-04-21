# frozen_string_literal: true

require './game'

class Hand
  attr_accessor :cards, :score

  def initialize
    @cards = []
    @score = 0
    @ace = 0
  end

  def scoring
    @cards.sort_by { |card| Game::SCORE_TABLE[card.rank] }.each do |card|
      @ace += 1 if card.rank == 'A'
      @score += Game::SCORE_TABLE[card.rank]
      @score -= 10 if @ace > 0 && @score > Game::WIN_SCORE
    end
  end

  def enough
    @score >= 17
  end
end
