require 'json'
require 'open-uri'

class Song < ApplicationRecord
  has_many :sentences
  belongs_to :album

  has_many :words, through: :sentences
  has_one :artist, through: :albums

  def get_genius_info
    api_key = ENV["GENIUS_API_KEY"]
    url = "https://api.genius.com/songs/#{genius_id}?access_token=#{api_key}"
    song_info = JSON.parse(open(url).read, object_class: OpenStruct).response.song

    self.release_date = song_info.release_date
    self.genius_views = song_info.stats.pageviews
    self.save
  end
end
