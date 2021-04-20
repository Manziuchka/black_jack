# frozen_string_literal: true

require './card'

class Deck
  attr_accessor :deck_of_cards, :card

  def initialize
    @deck_of_cards = []
    Card::SUIT.each do |suit|
      Card::RANK.each do |rank|
        @deck_of_cards << Card.new(suit, rank)
      end
    end
    @deck_of_cards.shuffle!
  end

  def take_card
    @card = @deck_of_cards.pop
  end
end
