require './attempt.rb' 
require './game.rb' 
require './code.rb' 
require 'pry-byebug' 

def take_turn(computer_code, current_game, turns_remaining, past_attempts)
  current_attempt = { :turn => (13 - turns_remaining) }
  puts "You have #{turns_remaining} turns left."
  puts "Enter your guess."
  current_attempt[:guess] = Attempt.new(gets.chomp).guess
  puts "Your current attempt is #{current_attempt}."
  puts "Checking your guess against the secret code..."
  current_attempt[:outcome] = []
  sleep 1
  current_attempt[:guess].each_with_index do |char, index|
    if char == computer_code.secret_code[index]
      current_attempt[:outcome][index] = "X"
    elsif computer_code.secret_code.include?(char)
      current_attempt[:outcome][index] = "/"
    else  
      current_attempt[:outcome][index] = "__"
    end
  end
  if current_attempt[:outcome].all?("X")
    current_game.is_over = true 
    puts "You win! You guessed the secret code!"
  else
    puts "Here is the outcome of your guess:"
    puts current_attempt[:outcome]
    past_attempts.push(current_attempt)
  end

end



def play_mastermind
  past_attempts = []
  turns_remaining = 12
  puts "The computer is thinking of a secret code now..."
  sleep 1
  computer_code = Code.new()
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

  12.times do 
    if (turns_remaining > 0 && current_game.is_over == false)
      take_turn(computer_code, current_game, turns_remaining, past_attempts)
      turns_remaining -= 1
    else
      puts "The game is over."
    end
  end

end

play_mastermind


  