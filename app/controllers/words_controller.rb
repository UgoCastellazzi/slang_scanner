class WordsController < ApplicationController
  def show
    @word = Word.find(params[:id])
    @songs = @word.order_songs_by_increasing_release_date
  end
end
