# frozen_string_literal: true

require './card'

class Deck
  attr_reader :deck_of_cards

  def initialize
    @deck_of_cards = []
    Card::SUIT.each do |suit|
      Card::RANK.each do |rank|
        @deck_of_cards << Card.new(suit, rank)
      end
    end
    @deck_of_cards.shuffle!
  end
end
