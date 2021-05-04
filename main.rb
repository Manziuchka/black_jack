# frozen_string_literal: true

require './game'

class Main
  def interface
    start_game
    gameplay
  end

  def start_game
    puts 'Введите имя игрока'
    name = gets.chomp
    @game = Game.new(name)
  end

  def gameplay
    @game.make_bet
    @game.deal_cards
    puts 'Игра началась. Ставки сделаны, карты раздали.'
    loop do
      open_hand if (@game.player.hand.cards.size == 3) && (@game.dealer.hand.cards.size == 3)
      help
      choice = gets.to_i
      case choice
      when 1
        'Ваши карты: '
        puts @game.player.hand.show_cards
      when 2
        add_card_and_dealer_move
      when 3
        @game.dealer_action
        puts 'Ход пропущен'
      when 4
        open_hand
      when 5
        clear_hands
        gameplay
      end
      break if choice == 0
    end
  end

  def help
    puts "Выберите действие:
            1 - посмотреть свои карты
            2 - добавить одну карту
            3 - пропустить ход
            4 - открыть карты
            5 - сыграть еще раз
            0 - закрыть игру"
  end

  def clear_hands
    @game.dealer.hand.clear_hand
    @game.player.hand.clear_hand
  end

  def add_card_and_dealer_move
    if @game.player.hand.cards.size < 3
      @game.add_card(@game.player)
      puts 'Карта добавлена'
    else
      puts 'Может быть добавлена только 1 карта'
    end
    puts 'Ход переходит диллеру'
    @game.dealer_action
  end

  def open_hand
    puts 'Ваши карты: '
    puts @game.player.hand.show_cards
    puts 'Ваши очки: '
    puts @game.player.hand.scoring
    puts 'Карты диллера: '
    puts @game.dealer.hand.show_cards
    puts 'Очки диллера: '
    puts @game.dealer.hand.scoring
    puts "Выиграл: #{winner_name}"
    @game.payout
    puts "Банк диллера: #{@game.dealer.bank_limit}"
    puts "Банк игрока: #{@game.player.bank_limit}"
    puts "Карт в колоде: #{@game.deck.card_amount}"
  end

  def winner_name
    if @game.winner.instance_of?(Array)
      'Ничья'
    else
      @game.winner.name
    end
  end

  Main.new.interface
end
