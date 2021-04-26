# frozen_string_literal: true

require './dealer'
require './deck'
require './hand'

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

  def initialize(name)
    @dealer = Dealer.new
    @player = Player.new(name)
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

  def winner
    return @player if player_score > dealer_score && not_overdo(@player)
    return @dealer if dealer_score > player_score && not_overdo(@dealer)

    [@player, @dealer]
  end

  def payout
    @winner = winner
    if @winner.instance_of?(Array)
      @pay = @bank / @winner.size
      @winner.each { |winner| winner.bank_limit += @pay }
    else
      @winner.bank_limit += @bank
    end
  end

  def dealer_action
    if @dealer.hand.enough
      puts "Карт у диллера достаточно"
    else
      self.add_card(@dealer)
    end
  end

  private

  def player_score
    @player.hand.scoring
  end

  def dealer_score
    @dealer.hand.scoring
  end

  def not_overdo(player)
    player.hand.scoring <= WIN_SCORE
  end
end
