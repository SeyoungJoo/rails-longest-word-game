require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
      letters = Array('A'..'Z')
      @picked_chars = Array.new(10) { letters.sample }
  end

  def score
    @original_grid = params[:attempt].split(' ').join(',')
    response = open("https://wagon-dictionary.herokuapp.com/#{params[:attempt]}")
    json = JSON.parse(response.read.to_s)
    @json_result = json["found"]
    if params[:attempt].split('').all? { |letter| @original_grid.include? letter }
      if @json_result == true
        @result = "Congratulatioins! #{params[:attempt]} is a valid English word!"
      else
        @result = "Sorry but #{params[:attempt]} does not seem to be a valid English word..."
      end
    else
      @result = "Sorry but TEST can not be built our of #{@original_grid}"
    end
  end
end
