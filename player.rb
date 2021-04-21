# frozen_string_literal: true

require_relative 'deck'
require_relative 'hand'

class Player
  attr_accessor :name, :bank_limit, :hand

  def initialize(name)
    @name = name
    @bank_limit = 100
    @hand = Hand.new
  end

  def place_bet
    @bank_limit -= Game::BET
  end
end
