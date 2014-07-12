class Hangman

  def initialize(guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
  end

  def play
    show_blank_word
    while show_word.any
    end
  end

  def show_word
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
    @length = gets.to_i
  end

  def receive_secret_length
  end

  def guess
    puts "Guess a letter: "
    letter = gets.chomp
  end

  def check_guess(letter)
  end

  def handle_guess_response
  end

  def completed_word
  end

end

class ComputerPlayer

  attr_reader :secret_word, :length, :completed_word

  def initialize
    @secret_word = ''
    @length = 0
    @completed_word = []
  end

  def pick_secret_word
    dictionary = File.readlines('dictionary.txt')
    dictionary.each do |x|
      x.chomp!
    end
    @secret_word = dictionary.sample
  end

  def receive_secret_length
    @length = @secret_word.length
  end

  def guess
  end

  def check_guess(letter)
    secret_word.split.each_with_index do |x,idx|
      if x == letter
        @completed_word[idx] = letter
      end
    end
  end

  def handle_guess_response
  end

  def completed_word
  end

end

if __FILE__ == $PROGRAM_NAME
  Hangman.new(HumanPlayer.new, ComputerPlayer.new)
end