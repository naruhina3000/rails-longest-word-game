require "open-uri"
# always put in the library
require "json"

class GamesController < ApplicationController
    def new
        new_grid
    end

    def score
        @answer = params[:answer]
        @answer_array = @answer.upcase.chars
        @grid_array = params[:grid].split
        @url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
        @dictionary_read = open(@url).read
        @dictionary = JSON.parse(@dictionary_read)
        if @dictionary['found'] == false
        @score_text = "Your word: #{@answer.upcase} does not exist / is not an english word"
        elsif !@answer_array.all? { |letter| @grid_array.count(letter) >= @answer_array.count(letter) }
        @score_text = "Your word: #{@answer.upcase} either not in the grid and/or letter overused"
    	else 
        @word_length = @dictionary['length'].to_i
        @score_text = "Your word: #{@answer.upcase} is correct, well done. Your score is #{@word_length}"
        end
    end

    private

    def new_grid
        @grid = Array.new(10){[*"A".."Z"].sample}
    end

end
