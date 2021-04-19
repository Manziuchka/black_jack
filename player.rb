# frozen_string_literal: true

class Player
  attr_accessor :name, :bank

  def initialize(name)
    @name = name
    @bank = 100
  end
end
