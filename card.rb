class Card
  attr_accessor :suit, :rank

  SUIT = %w(♠ ♣ ♥ ♦)
  RANK = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end
end