class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word 
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_accessor :guess
  def guess(let)
    raise ArgumentError unless (let =~ /[[:alpha:]]/)
    
    @guess = let.downcase
    @letters = @word.split('')
    for letter in @letters
      if letter == @guess
        if !guesses.include?@guess
          @guesses += @guess
          @wrong_guesses += ""
          return true
        end
        return false
      end
    end
    if !wrong_guesses.include?@guess
      @wrong_guesses += @guess
      @guesses += ""
      return true
    end
    return false
  end
  
  attr_accessor :word_with_guesses
  def word_with_guesses
    @part = ""
    @chars = @word.split('')
    for char in @chars
      if @guesses.include?char
        @part += char
      else
        @part += "-"
      end
    end
    return @part
  end
  
  attr_accessor :check_win_or_lose
  def check_win_or_lose
    if @wrong_guesses.length == 7
      return :lose
    elsif self.word_with_guesses = @word
      return :win
    else
      return :play
    end
  end


  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
  

end
