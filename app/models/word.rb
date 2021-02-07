class Word < ApplicationRecord
  has_many :sentences
  has_many :songs, through: :sentences

  after_create :search_results

  def search_results
    GetGeniusSearchResultsJob.perform_now(self)
  end

  def order_songs_by_increasing_release_date
    self.songs.sort { |a,b| a.release_date && b.release_date ? a.release_date <=> b.release_date : a.release_date ? -1 : 1 }
  end

  def get_top_song
    self.songs.sort { |a,b| a.genius_views && b.genius_views ? b.genius_views <=> a.genius_views : a.genius_views ? -1 : 1 }.first
  end
end
