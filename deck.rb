require './card.rb'

class Deck
  attr_reader :deck_of_cards

  def initialize
    @deck_of_cards = []
    Card::SUIT.each do |suit|
      Card::RANK.each do |rank|
        @deck_of_cards << Card.new(suit, rank)
      end
    end
  end

  def shuffle_deck
    @deck_of_cards.shuffle! unless @deck_of_cards.nil? || @deck_of_cards.size == 0
  end
end