class User
  attr_accessor :cards, :money
  attr_reader :name, :points
  
  def initialize(name)
    @name = name
    @money = 100
    @points = 0 
    @cards = []
  end

  def skip_move 
    true
  end

  def add_card(deck, count = 1)
    deck.remove_card(count).each {|card| @cards << card}
  end

  def remove_money(value)
    @money -= value
  end 

  def add_money(value)
    @money += value
  end

  def points
    @points = @cards.map(&:point).sum
    @cards.count { |card| card.point == 11 }.times do
      break if @points <= 21
      @points -= 10
    end
    return @points
  end

  def show_cards
    cards = ''
    @cards.each {|card| cards += "#{card.value}#{card.suit}"}
    return cards
  end
end

