require 'debugger'

class Hangman

  def initialize(guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
  end

  def play
    puts "Welcome to Hangman!"

    @checking_player.pick_secret_word
    p @checking_player.secret_word

    while @checking_player.completed_word.any? {|x| x == '_'} && @checking_player.wrong_guesses < 5
      p @checking_player.completed_word

      guess = @guessing_player.guess

      break if guess == @checking_player.secret_word

      @checking_player.check_guess(guess)

      break if won?
      puts "You have #{@checking_player.wrong_guesses} wrong guesses."
    end

    if @checking_player.wrong_guesses == 5
      puts "You lose.  So sorry."
    else
      puts "You win! Thank you for playing Hangman!"
    end
  end

  def won?
    false
    return true if @checking_player.completed_word.none? {|x| x == '_'}
  end



end

class HumanPlayer

  attr_reader :secret_word, :length, :completed_word

  def initialize
    @secret_word = ''
    @length = 0
    @completed_word = []
  end

  def pick_secret_word
    puts "How long is your secret word?"
    length = gets.to_i
    make_blank_board(length)
  end

  def receive_secret_length

  end

  def guess
    puts "Guess a letter (or the word if you know it!): "
    gets.chomp
  end

  def check_guess(letter)
    letter.downcase!

    puts "Correct guess by other player?"
    answer = gets.chomp

    if answer.downcase == 'y'
      puts "Please place the letters in their correct positions and type DONE when finished."
      response = ''
      loop do
        response = gets.chomp
        break if response.downcase == "done"
        index = response.to_i - 1
        @completed_word[index] = letter
      end
    else
      wrong_guess
    end
  end

  def wrong_guess
    @wrong_guesses += 1
    puts "Stupid computer."
  end

  def right_word?(guess)
    true
    if guess != @secret_word
      puts "Sorry! Wrong word."
      false
    end
  end

  def handle_guess_response(letter,index)
    @completed_word[index] = letter
  end

  def make_blank_board(length)
    length.times do
      @completed_word << "_"
    end
  end

end

class ComputerPlayer

  attr_reader :secret_word, :length, :completed_word, :wrong_guesses

  def initialize
    @secret_word = ''
    @completed_word = []
    @wrong_guesses = 0
    @alphabet = ("a".."z").to_a
  end

  def pick_secret_word
    dictionary = File.readlines('dictionary.txt')

    dictionary.each do |x|
      x.chomp!
    end

    @secret_word = dictionary.sample

    receive_secret_length

    make_blank_board
  end

  def receive_secret_length
    #receive how long the other player's secret word is so
    #the computer can guess intelligently
  end

  def guess
    guess = alphabet.sample

    alphabet.delete(guess)

    puts guess

    guess
  end

  def check_guess(guess)
    return if wrong_guess?(guess)
    secret_word.split(//).each_with_index do |x,idx|
      if x == guess
        handle_guess_response(guess,idx)
      end
    end
  end

  def wrong_guess?(letter)
    false
    if secret_word.split(//).none? {|x| x == letter}
      puts "Bad form, Peter. Guess again"
      @wrong_guesses += 1
      return true
    end
  end

  def right_word?(guess)
    true
    if guess != @secret_word
      puts "Sorry! Wrong word."
      false
    end
  end

  def handle_guess_response(letter,index)
    @completed_word[index] = letter
    puts "Correct!"
  end

  def make_blank_board
    @secret_word.length.times do
      @completed_word << "_"
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  Hangman.new(HumanPlayer.new, ComputerPlayer.new)
end