require_relative 'card'

class Deck
  attr_accessor :cards

  SUITS  = ["\u2660", "\u2663", "\u2665", "\u2666"].freeze
  VALUES_AND_POINTS = {
    "2" => 2, 
    "3" => 3, 
    "4" => 4, 
    "5" => 5, 
    "6" => 6, 
    "7" => 7,
    "8" => 8, 
    "9" => 9, 
    "10" => 10, 
    "J" => 10, 
    "Q" => 10, 
    "K" => 10, 
    "A" => 11
  }.freeze

  def initialize
    @cards = generate_deck
  end

  def generate_deck
    cards = [] 
    VALUES_AND_POINTS.each do |value, point|
      SUITS.each do |suit|
        cards << Card.new(value, suit, point)
      end
    end
    cards.shuffle!
  end

  def remove_card(count)
    if @cards.empty?
      @cards = generate_deck
    else  
      @cards.pop(count)
    end
  end
end
