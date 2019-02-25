require 'json'
require 'open-uri'
url = 'https://wagon-dictionary.herokuapp.com/'

class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].sample(10)
  end

  def score
    @word = params[:word].downcase.split('')
    @array_letters = params[:random_letters].downcase.split(' ')
    serialized_word = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
    unserialized_word = JSON.parse(serialized_word)
    @word.each do |letter|
      if @array_letters.include?(letter) && @word.count(letter) <= @array_letters.count(letter)
        if unserialized_word['found'] == true
          @results = "Congratulations! #{params[:word]} is a valid word"
        else
          @results = "Sorry but #{params[:word]} is not a English word"
          @word = []
        end
      else
        @results = "Sorry but #{params[:word]} can't be build out of #{params[:random_letters]}"
        @word = []
      end
    end
    session[:score] = session[:score] + @word.length
    @score = session[:score]
  end
end
