class Word < ApplicationRecord
  has_many :sentences
  has_many :songs, through: :sentences

  after_commit :search_results

  def search_results
    GetGeniusSearchResultsJob.perform_now(self)
  end

  def order_songs_by_increasing_release_date
    self.songs.sort { |a,b| a.release_date && b.release_date ? a.release_date <=> b.release_date : a.release_date ? -1 : 1 }
  end
end
