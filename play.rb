require './attempt.rb' 
require './game.rb' 
require './code.rb' 
require 'pry-byebug' 

def take_turn_breaker(computer_code, current_game, turns_remaining, past_attempts)
  current_attempt = { :turn => (13 - turns_remaining) }
  puts "\n \n"
  puts "You have #{turns_remaining} turns left."
  puts "Enter your guess."
  current_attempt[:guess] = Attempt.new(gets.chomp).guess
  puts "Your current attempt is #{current_attempt}."
  puts "Checking your guess against the secret code..."
  current_attempt[:outcome] = []
  sleep 1
  current_attempt[:guess].each_with_index do |char, index|
    if char == computer_code.secret_code[index]
      current_attempt[:outcome][index] = " X "
    elsif computer_code.secret_code.include?(char)
      current_attempt[:outcome][index] = " / "
    else  
      current_attempt[:outcome][index] = " __ "
    end
  end
  if current_attempt[:outcome].all?(" X ")
    current_game.is_over = true 
    puts "You win! You guessed the secret code!"
  else
    puts "Here is the outcome of your guess:"
    print "#{current_attempt[:outcome].sort.join("")}\n"
    past_attempts.push(current_attempt)
  end

end

def play_mastermind_breaker
  past_attempts = []
  turns_remaining = 12
  puts "The computer is thinking of a secret code now..."
  sleep 1
  computer_code = Code.new("computer")
  puts "The computer has chosen its secret code."
  puts "Now it's time to make the game. Who is playing?"
  current_game = Game.new(gets.chomp)
  puts "Excellent. Good luck #{current_game.player}!"
  puts "Here are the rules. You have 12 guesses to figure out the computer's secret code."
  puts "Each guess you make must include four capital letters ('B', 'Y', 'G', 'R', 'W', or 'P') without spaces."
  puts "After each guess, the computer will tell you whether the secret code contained that letter and whether the letter was in the correct place."
  puts "An 'X' means you guessed the correct letter in the correct location. A '/' means you had the right letter but it was in the wrong location."
  puts "A '__' means the secret code does not contain that letter."
  puts "If you guess the secret code exactly within 12 turns, you win! Let's get started."

  13.times do 
    if (turns_remaining > 0 && current_game.is_over == false)
      take_turn_breaker(computer_code, current_game, turns_remaining, past_attempts)
      turns_remaining -= 1
    elsif (turns_remaining == 0 && current_game.is_over == false)
      puts "You lost."
    end
  end

  return "The game is over."

end

def random_guess
  arr = []
  dict = ["B", "Y", "G", "R", "W", "P"]
  4.times do 
    arr.push(dict[Random.rand(0..5)])
  end
  return arr.join("")
end

def take_turn_maker(player_code, current_game, turns_remaining, past_attempts)
  current_attempt = { :turn => (13 - turns_remaining) }
  puts "\n \n"
  puts "The computer has #{turns_remaining} turns left."
  puts "The computer is guessing..."
  sleep 1
  current_attempt[:guess] = Attempt.new(random_guess).guess
  puts "The current attempt is #{current_attempt}."
  puts "Checking the computer's guess against the secret code..."
  sleep 1
  current_attempt[:outcome] = []
  sleep 1
  current_attempt[:guess].each_with_index do |char, index|
    if char == player_code.secret_code[index]
      current_attempt[:outcome][index] = " X "
    elsif player_code.secret_code.include?(char)
      current_attempt[:outcome][index] = " / "
    else  
      current_attempt[:outcome][index] = " __ "
    end
  end
  if current_attempt[:outcome].all?(" X ")
    current_game.is_over = true 
    puts "The computer wins! It guessed the secret code!"
  else
    puts "Here is the outcome of the guess:"
    print "#{current_attempt[:outcome].sort.join("")}\n"
    past_attempts.push(current_attempt)
  end
  sleep 2
end

def play_mastermind_maker
  past_attempts = []
  turns_remaining = 12
  current_game = Game.new("computer")
  puts "You chose to make the code. The computer has 12 turns to try to break it."
  puts "Enter your code by typing four capital letters ('B', 'Y', 'G', 'R', 'W', or 'P') without spaces."
  player_code = Code.new(gets.chomp)
  puts "Your code is #{player_code.secret_code}"
  puts "Now, the computer gets to guess. Good luck!"
  sleep 1

  13.times do 
    if (turns_remaining > 0 && current_game.is_over == false)
      take_turn_maker(player_code, current_game, turns_remaining, past_attempts)
      turns_remaining -= 1
    elsif (turns_remaining == 0 && current_game.is_over == false)
      puts "The computer lost."
    end
  end

  return "The game is over."

end

puts "Would you like to BREAK the code? Or MAKE the code?"
puts "Enter your choice in all caps."

game_mode = gets.chomp

if game_mode == "BREAK"
  play_mastermind_breaker
elsif game_mode == "MAKE"
  play_mastermind_maker
else
  puts "GAME MODE ERROR"
end


  