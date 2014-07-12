class Hangman

  def initialize(guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
  end

  def play
    show_blank_word
    while show_word.any
  end

  def show_word
    board = []

    @guessing_player.length.times do
      board << "_"
    end

    board
  end
end

class HumanPlayer

  attr_reader :secret_word, :length

  def initialize
    @secret_word = ''
  end

  def pick_secret_word
  end

  def receive_secret_length
  end

  def guess
    puts "Guess a letter: "
    letter = gets.chomp
  end

  def check_guess
  end

  def handle_guess_response
  end

end

class ComputerPlayer

  attr_reader :secret_word, :length

  def initialize
    @secret_word = ''
    @length = 0
  end

  def pick_secret_word
    dictionary = File.readlines('dictionary.txt').chomp
    @secret_word = dictionary.sample
  end

  def receive_secret_length
    @length = @secret_word.length
  end

  def guess
  end

  def check_guess
  end

  def handle_guess_response
  end

end

if __FILE__ == $PROGRAM_NAME
  Hangman.new(HumanPlayer.new, ComputerPlayer.new)
end