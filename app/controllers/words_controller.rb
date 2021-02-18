class WordsController < ApplicationController
  def show
    @word = Word.find(params[:id])
    @songs = @word.order_songs_by_increasing_release_date
    @sentences = @word.sentences
    @top_sentence = @word.get_top_song.sentences.first
    @songs_data = Song.group_by_month(:release_date, format: "%b %Y").count
  end
end
