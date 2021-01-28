class Word < ApplicationRecord
  has_many :sentences

  has_many :songs, through: :sentences
end
