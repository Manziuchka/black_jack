# frozen_string_literal: true

require './dealer'
require './deck'

class Game
  attr_accessor :player, :dealer, :deck, :bank

  BET = 10
  WIN_SCORE = 21
  SCORE_TABLE = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 10,
    'J' => 10,
    'Q' => 10,
    'K' => 10,
    'A' => 11
  }.freeze

  def initialize
    @dealer = Dealer.new
    @player = Player.new('Mike')
    @deck = Deck.new
    @bank = 0
  end
end
