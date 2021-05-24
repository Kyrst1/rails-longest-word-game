require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      x = ('A'..'Z').to_a.sample
      @letters << x
    end
    @letters
  end

  def score
    # raise
    yes = "Congrats! #{params[:score].upcase} is a valid English word!"
    no = "Sorry but #{params[:score].upcase} is not an English word"
    @word = params[:score].split('')
    @a1 = @word.map {|letter| letter.upcase} 
    @input = params[:letters].split('')
    @a2 = @input.map {|letter| letter.upcase} 
    url = "https://wagon-dictionary.herokuapp.com/#{params[:score]}"
    user_serialized = URI.open(url).read
    response = JSON.parse(user_serialized)
    valid = response["found"]
    (@a1 - @a2).empty? && valid ? @score = yes : @score = no
    if (@a1 - @a2).empty? == false
      @score = "Sorry but #{params[:score].upcase} can't be built out of #{params[:letters].upcase}"
    end
  end
end
