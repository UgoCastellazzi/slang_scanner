class WordsController < ApplicationController
  def show
    @word = Word.find(params[:id])
    @songs = @word.order_songs_by_increasing_release_date
    @sentences = @word.sentences
    @top_sentence = @word.get_top_song.sentences.first.content
  end
end
