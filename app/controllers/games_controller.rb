class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @letters = []
    letters_size = 10
    while letters_size != 0
      @letters.push(("a".."z").to_a.sample(1))
      letters_size -= 1
    end
    return @letters
  end

  def score
    params[:letters] = params[:letters].downcase.chars
    url = "https://wagon-dictionary.herokuapp.com/#{params[:longword]}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    if params[:longword].downcase.chars.all? { |wordletter| params[:letters].count(wordletter) >= params[:longword].count(wordletter) }
      if word["found"]
        @result = "Congratulations! #{params[:longword]} is a valid English word!"
      else
        @result = "Sorry but #{params[:longword]} does not seem to be a valid English word..."
      end
    else
      @result = "Sorry but #{params[:longword]} can't be built out of #{params[:letters]}"
    end
    return @result
  end
end
