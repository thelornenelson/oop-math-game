require './player'

class MathGame

  def initialize
    @starting_lives = 3
    @players = [Player.new(@starting_lives), Player.new(@starting_lives)]
    @max_question_number = 20
    self.start_game
  end

  def start_game
    current_player = 0

    loop do

      current_player %= 2
      answers = self.ask_question(current_player)
      if check_answer(answers)
        puts "That's correct! Good Work!"
      else
        @players[current_player].lives -= 1
        if @players[current_player].lives.zero?
          puts "Incorrect! Game Over!"
          current_player = (current_player + 1) % 2
          puts "Player #{current_player + 1} Wins with a score of #{@players[current_player].lives}/#{@starting_lives}"
          break
        else
          puts "Incorrect! You lose a life!"
        end
      end
      puts "P1: #{@players[0].lives}/#{@starting_lives} vs P2: #{@players[1].lives}/#{@starting_lives}"
      puts '----- NEW TURN -----'
      current_player += 1
    end

  end

  def ask_question(player)
    x = 1 + Random.rand(@max_question_number)
    y = 1 + Random.rand(@max_question_number)

    p "Player #{player + 1}, what is #{x} + #{y}? "

    player_answer = 0

    while player_answer < 1
      player_answer = gets.chomp.to_i
      p "That's not a valid guess. What is #{x} + #{y}? " if player_answer < 1
    end

    return { player_answer: player_answer, answer: x + y }

  end

  def check_answer(answers)
    answers[:player_answer] == answers[:answer] ? true : false
  end

end
