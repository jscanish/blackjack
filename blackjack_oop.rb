require 'pry'

class Card
  attr_accessor :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    "#{@value} of #{@suit}"
  end
end


class Deck
  attr_accessor :cards

  def initialize
    @cards =[]

    %w[hearts spades diamonds clubs].each do |suit|
      %w[2 3 4 5 6 7 8 9 10 Jack Queen King Ace].each do |value|
        @cards << Card.new(suit, value)

        @cards.shuffle!
      end
    end
  end

  def deal
    cards.pop
  end

  def size
    cards.size
  end
end

module Hand

  def show_hand
    puts "#{name}'s hand:"
    @cards.each do |card|
      puts "#{card.to_s}"
    end
  end

  def total
    values = cards.map { |card| card.value }

    total = 0

    values.each do |value|
      if value == "Ace"
        total += 11
      elsif value == "King" || value == "Queen" || value == "Jack"
        total += 10
      else
        total += value.to_i
      end
    end

    values.select{ |v| v == "Ace" }.count.times do
      total -= 10 if total > 21
    end
    total
  end

  def deal_card(new_card)
    cards << new_card
  end

  def busted?
    total > 21
  end
end




class Player
  include Hand
  attr_accessor :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end
end


class Dealer
  include Hand
  attr_accessor :name, :cards

  def initialize
    @name = "dealer"
    @cards = []
  end

  def show_one_card
    puts "The dealer is showing the #{cards[1]}."
  end
end

class Blackjack
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new('Player1')
    @dealer = Dealer.new
  end

  def check_blackjack_or_bust(player_or_dealer)
    if player_or_dealer.total == 21
      if player_or_dealer.is_a?(Dealer)
        dealer.show_hand
        puts "The dealer has blackjack. You lose!"
      else
        puts "Blackjack! #{player.name} wins!"
      end
      exit
    elsif player_or_dealer.busted?
      if player_or_dealer.is_a?(Dealer)
        dealer.show_hand
        puts "The dealer busted. #{player.name} Wins!"
      else
        puts "You busted! You lose!"
      end
      exit
    end
  end

  def get_name
    puts "What's your name?"
    player.name = gets.chomp
    player.name.capitalize!
    puts "Ok #{player.name}, let's play blackjack!"
    puts ''
  end

  def initial_deal
    player.deal_card(deck.deal)
    dealer.deal_card(deck.deal)
    player.deal_card(deck.deal)
    dealer.deal_card(deck.deal)
  end

  def show_initial_deal
    dealer.show_one_card
    puts ''
    player.show_hand
    puts "You have a total of #{player.total}."
    check_blackjack_or_bust(player)
  end

  def player_turn

    check_blackjack_or_bust(player)

    while player.total < 21
      puts "Would you like to hit or stay?"
      response = gets.chomp

      if response != "hit" && response != "stay"
        puts "plese type \"hit\" or \"stay.\""
        next
      end

      if response == 'stay'
        puts "You have chosen to stay with #{player.total}."
        puts ''
        break
      end

      new_card = deck.deal
      puts ''
      player.deal_card(new_card)
      puts "You've been dealt the #{new_card}."
      puts "You have a total of #{player.total}."
      check_blackjack_or_bust(player)

    end
  end

  def dealer_turn
    dealer.show_hand
    check_blackjack_or_bust(dealer)
    while dealer.total < 17
      dealer_card = deck.deal
      puts ''
      dealer.deal_card(dealer_card)
      puts "The dealer draws a #{dealer_card}."

      check_blackjack_or_bust(dealer)
    end


    puts "The dealer stays with #{dealer.total}."
  end

  def compare_totals(player, dealer)
    if player.total > dealer.total
      puts "You win!"
    elsif dealer.total > player.total
      puts "You lose!"
    else
      puts "It's a tie!"
    end
  end

  def start
    get_name
    initial_deal
    show_initial_deal
    player_turn
    dealer_turn
    compare_totals(player, dealer)
  end
end


blackjack = Blackjack.new
blackjack.start












