require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'card'

class Game
  attr_accessor :bank

  def initialize
    @bank = 0
    puts 'Enter player name:'
    name = gets.chomp
    @player = Player.new(name)
    @dealer = Dealer.new
    @deck = Deck.new
    pre_start
  end

  PLAYER_MENU = ['Skip move', 'Add card', 'Open cards'].freeze
  AGAIN_MENU  = %w[Again Exit].freeze

  def menu(menu)
    menu.each_with_index { |i, n| puts "#{n + 1} #{i}" }
  end

  def pre_start
    @player.add_card(@deck, 2)
    @dealer.add_card(@deck, 2)
    add_bank(@player, 10)
    add_bank(@dealer, 10)
    puts "Bank is #{@bank}"
  end

  def start
    loop do
      auto_result
      player_actions
      dealer_actions
    end
  end

  def player_actions
    puts '--- Player move ---'
    menu(PLAYER_MENU)
    number = gets.chomp.to_i
    case number
    when 1
      @player.skip_move
    when 2
      @player.add_card(@deck)
    when 3
      result
    end
  end

  def dealer_actions
    puts '--- Dealer move ---'
    if @dealer.points >= 17
      @dealer.skip_move
      puts 'Dealer skip move'
    elsif @dealer.points < 17
      @dealer.add_card(@deck)
      puts 'Dealer add card ****'
    end
  end

  def result
    if (@dealer.points < @player.points) && (@player.points <= 21) || (@dealer.money == 0) 
      puts 'Player win!'
      remove_bank(@player, @bank)
      puts "Player cards: #{@player.show_cards}. Player points: #{@player.points}. Player money: #{@player.money}"
      puts "Dealer cards: #{@dealer.show_cards}. Dealer points: #{@dealer.points}. Dealer money: #{@dealer.money}"
    elsif (@dealer.points > @player.points) && (@dealer.points <= 21) || (@player.money == 0)
      puts 'Dealer win!'
      remove_bank(@dealer, @bank)
      puts "Player cards: #{@player.show_cards}. Player points: #{@player.points}. Player money: #{@player.money}"
      puts "Dealer cards: #{@dealer.show_cards}. Dealer points: #{@dealer.points}. Dealer money: #{@dealer.money}"
    elsif @player.points == @dealer.points
      puts 'Draw!'
      remove_bank(@player, @bank / 2)
      remove_bank(@dealer, @bank / 2)
      puts "Player cards: #{@player.show_cards}. Player points: #{@player.points}. Player money: #{@player.money}"
      puts "Dealer cards: #{@dealer.show_cards}. Dealer points: #{@dealer.points}. Dealer money: #{@dealer.money}"
    end
    again 
  end

  def auto_result
    result if @player.cards.count == 3 && @dealer.cards.count == 3
  end

  def again
    puts '--- Again? ---'
    menu(AGAIN_MENU)
    number = gets.chomp.to_i
    case number
    when 1
      if @player.money == 0 || @dealer.money == 0
        @player.money = 100
        @dealer.money = 100
      end
      @player.cards.clear
      @dealer.cards.clear
      pre_start
      start
    when 2
      exit
    end
  end

  def add_bank(user, money)
    user.remove_money(money)
    @bank += money
  end

  def remove_bank(user, money)
    user.add_money(money)
    @bank -= money
  end
end

Game.new.start
