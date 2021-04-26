# frozen_string_literal: true

require './game'

class Main
  puts "Введите имя игрока"
  name = gets.chomp
  @game = Game.new(name)
  puts @game.make_bet
  puts @game.deal_cards
  puts "Игра началась. Ставки сделаны, карты раздали."
  loop do
    puts "Выберите действие:
          1 - посмотреть свои карты
          2 - добавить одну карту
          3 - пропустить ход
          4 - открыть карты"
    choice = gets.to_i
    case choice
      when 1
      "Ваши карты: "
      puts @game.player.hand.show_cards
      when 2
        if @game.player.hand.cards.size == 3
          puts "Может быть добавлена только одна карта"
        else
        @game.add_card(@game.player)
        puts "Карта добавлена"
        end
        @game.dealer_action if @game.dealer.hand.cards.size == 2
      when 3
        @game.dealer_action
        puts "Ход пропущен"
      when 4
        puts "Ваши карты: "
        puts @game.player.hand.show_cards
        puts "Карты диллера: "
        puts @game.dealer.hand.show_cards
    end
    break if choice == 0
  end
end
