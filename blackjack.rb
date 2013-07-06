
deck = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11] * 4 * 4
#simulates a casino playing with 4 decks

suit = ["hearts", "diamonds", "clubs", "spades"]
#by randomly sampling the suit array, I can create the illusion of multiple decks

deck.shuffle!

player_cards = []
dealer_cards = []

player_cards << deck.pop
player_cards << deck.pop
dealer_cards << deck.pop
dealer_cards << deck.pop

player_total = player_cards.reduce :+
dealer_total = dealer_cards.reduce :+

puts "The dealer has a #{dealer_cards[0]} of #{suit.sample} and a #{dealer_cards[1]} of #{suit.sample}."
puts "You have a #{player_cards[0]} of #{suit.sample} and a #{player_cards[1]} of #{suit.sample}."
  if (player_total == 21) && (dealer_total == 21)
  puts "You tied the computer!"
  exit
elsif player_total == 21
  puts "Blackjack, you win!"
  exit
elsif dealer_total == 21
  puts "The dealer has 21. You lose!"
  exit
else
  puts ""
  puts "Would you like to hit or stay?"
end
response = gets.chomp

while player_total < 21
  if response == "hit"
    player_cards << deck.pop

    puts "You have been dealt a #{player_cards.last} of #{suit.sample}."
    player_total = player_cards.reduce :+


    if player_total == 21
      puts "Blackjack! You win!"
      exit
    elsif player_total > 21
      player_cards.select{|c| c == 11}.count.times do
      player_total -= 10 if player_total > 21
      end
      puts "Busted! You lose!" if player_total > 21
      exit if player_total > 21
      puts "You now have a total of #{player_total}." if player_total < 21
      puts "would you like to hit again? (hit or stay" if player_total < 21
      response = gets.chomp

    else
      puts ""
      puts "You now have #{player_total}."
      puts "would you like to hit again? (hit or stay)"
      response = gets.chomp
    end
  else
    player_total = player_cards.reduce :+
    puts "You have chosen to stay at #{player_total}."
    break
  end
end

while dealer_total < 17
  if player_total > 21
    puts "The dealer wins!"
    break
  elsif player_total < 21
    dealer_cards << deck.pop
    puts ""
    puts "The dealer takes a #{dealer_cards.last} of #{suit.sample}."
    dealer_total = dealer_cards.reduce :+
  end
end


if dealer_total > 16 && dealer_total < 22
  puts "The dealer stays with #{dealer_total}."
elsif dealer_total > 21
  puts "The dealer busted! You win!"
end

if dealer_total == 21
  puts "The dealer has 21! You lose!"
  exit
end

if player_total < 21 && dealer_total < 21
  if player_total > dealer_total
    puts "You win!"
  else
    puts "Sorry, you lose!"
  end
end


