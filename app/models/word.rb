class Word < ApplicationRecord
  has_many :sentences
  has_many :songs, through: :sentences

  after_commit :search_results

  def search_results
    GetGeniusSearchResultsJob.perform_now(self)
  end
end
