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
    if (@player.bank_limit && @dealer.bank_limit) >= BET
      @player.place_bet
      @dealer.place_bet
      @bank = BET * 2
    else
      raise 'Недостаточно средств'
    end
  end

  def deal_cards
    2.times do
      add_card(@player)
      add_card(@dealer)
    end
  end

  def add_card(player)
    player.hand.cards << @deck.take_card if player.hand.cards.size < 3
  end

  def winner
    return @player if !overdo(@player) && (player_score > dealer_score || overdo(@dealer))
    return @dealer if !overdo(@dealer) && (dealer_score > player_score || overdo(@player))

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
    add_card(@dealer) unless @dealer.hand.enough
  end

  private

  def player_score
    @player.hand.scoring
  end

  def dealer_score
    @dealer.hand.scoring
  end

  def overdo(player)
    player.hand.scoring > WIN_SCORE
  end
end
