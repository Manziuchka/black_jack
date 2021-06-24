# frozen_string_literal: true

module Interface
  module_function

  def player_name
    puts 'Введите имя пользователя:'
    gets.chomp
  end

  def help
    puts "Выберите действие:
            1 - посмотреть свои карты
            2 - добавить одну карту
            3 - пропустить ход
            4 - открыть карты
            5 - сыграть еще раунд
            0 - закрыть игру"
  end

  def new_round
    puts 'Новый раунд'
  end

  def open_hand(game)
    puts "Ваши карты: #{game.player.hand.show_cards}"
    puts "Ваши очки: #{game.player.hand.scoring}"
    puts "Карты диллера: #{game.dealer.hand.show_cards}"
    puts "Очки диллера: #{game.dealer.hand.scoring}"
    puts "Победитель: #{game.winner_name}"
  end

  def show_bank(game)
    puts "Банк диллера: #{game.dealer.bank_limit}"
    puts "Банк игрока: #{game.player.bank_limit}"
    puts "Карт в колоде: #{game.deck.card_amount}"
  end

  def show_player_cards(game)
    puts "Ваши карты: #{game.player.hand.show_cards}"
  end

  def skip_move
    puts 'Ход пропущен'
  end

  def add_card
    puts 'Карта добавлена'
  end

  def overdo_error
    puts 'Может быть добавлена только 1 карта'
  end

  def dealer_turn
    puts 'Ход переходит диллеру'
  end

  def dead_heat
    puts 'Ничья'
  end

  def end_game
    puts 'Спасибо за игру.'
  end
end
