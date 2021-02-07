require 'json'
require 'open-uri'

class Song < ApplicationRecord
  has_many :sentences
  belongs_to :artist

  has_many :words, through: :sentences

  def get_genius_info
    api_key = ENV["GENIUS_API_KEY"]
    url = "https://api.genius.com/songs/#{genius_id}?access_token=#{api_key}"
    song_info = JSON.parse(open(url).read, object_class: OpenStruct).response.song

    self.release_date = song_info.release_date
    self.genius_views = song_info.stats.pageviews
    self.save
  end

  def self.sort_by_increasing_release_date(word)
    song_list = Song.all.find_all{|song| song.words == word}
    song_list.sort { |a,b| a.release_date && b.release_date ? a.release_date <=> b.release_date : a.release_date ? -1 : 1 }
  end
end
