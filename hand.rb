# frozen_string_literal: true

require './game'

class Hand
  attr_accessor :cards, :score

  def initialize
    @cards = []
  end

  def scoring
    @score = 0
    @ace = 0
    @cards.sort_by { |card| Game::SCORE_TABLE[card.rank] }.each do |card|
      @ace += 1 if card.rank == 'A'
      @score += Game::SCORE_TABLE[card.rank]
      @score -= 10 if @ace.positive? && @score > Game::WIN_SCORE
    end
    @score
  end
  
  def show_cards
    @show = []
    self.cards.each{|card| @show << "[#{card.rank}#{card.suit}]"}
    @show.join
  end

  def enough
    scoring.to_i >= 17
  end
end
