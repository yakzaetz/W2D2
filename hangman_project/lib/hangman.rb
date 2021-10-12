class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses
  attr_writer :remaining_incorrect_guesses
  def self.random_word
    DICTIONARY.sample
  end

  def initialize()
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    if @attempted_chars.include?(char)
      return true 
    else
      return false
    end 
  end

  def get_matching_indices(letter)
    arr = []
    
    @secret_word.each_char.with_index do |char, i|
      if char == letter
        arr << i 
      end 
    end
    arr
  end

  def fill_indices(char, arr)
    arr.each { |i| @guess_word[i] = char }
  end

  def try_guess(char)
    if self.already_attempted?(char)
      p 'that has already been attempted'
        return false
    end

      @attempted_chars << char

    if self.get_matching_indices(char).empty?
      @remaining_incorrect_guesses -= 1
    else
      self.fill_indices(char, self.get_matching_indices(char))
    end  
    true 
  end

  def ask_user_for_guess
    'Enter a char:'
    char = gets.chomp
    return self.try_guess(char)
  end

  def win?
    if @guess_word.join == @secret_word
      p "WIN"
      return true
    else
      return false
    end 
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      p "LOSE"
      return true
    else
      return false
    end 
  end

  def game_over?
    if self.lose? || self.win?
      p @secret_word
      return true
    else
      return false
    end 
  end
  

end
