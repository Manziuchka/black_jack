# frozen_string_literal: true

require './dealer'
# require './deck'
# require './hand'
require_relative 'interface'

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
    @player = Player.new(Interface.player_name)
    @deck = Deck.new
    @bank = 0
  end

  def round
    make_bet
    deal_cards
    Interface.new_round
    loop do
      if (@player.hand.cards.size == 3) && (@dealer.hand.cards.size == 3)
        Interface.open_hand(self)
        payout
        Interface.show_bank(self)
      end
      Interface.help
      choice = gets.to_i
      case choice
      when 1
        Interface.show_player_cards(self)
      when 2
        add_card_and_dealer_move
      when 3
        dealer_action
        Interface.skip_move
      when 4
        Interface.open_hand(self)
        payout
        Interface.show_bank(self)
      when 5
        clear_hands
        round
      when 0
        Interface.end_game
        break
      end
    end
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

  def add_card_and_dealer_move
    if @player.hand.cards.size < 3
      add_card(@player)
      Interface.add_card
    else
      Interface.overdo_error
    end
    Interface.dealer_turn
    dealer_action
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

  def winner_name
    if winner.instance_of?(Array)
      Interface.dead_heat
    else
      winner.name
    end
  end

  def clear_hands
    @dealer.hand.clear_hand
    @player.hand.clear_hand
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
