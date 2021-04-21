# frozen_string_literal: true

require './dealer'
require './deck'
# require './hand'

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

  def make_bet
    @player.place_bet
    @dealer.place_bet
    @bank = BET * 2
  end

  def deal_cards
    2.times do
      add_card(@player)
      add_card(@dealer)
    end
  end

  def add_card(player)
    player.hand.cards << @deck.take_card
  end
end
