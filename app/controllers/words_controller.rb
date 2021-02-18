class WordsController < ApplicationController
  def show
    @word = Word.find(params[:id])
    @songs = @word.order_songs_by_increasing_release_date
    @songs_data = @songs.group_by_month(format: "%b %Y", series: true) { |u| u.release_date }.map { |k, v| [k, v.count] }.to_h
    @sentences = @word.sentences
    @top_sentence = @word.get_top_song.sentences.first    
  end
end
