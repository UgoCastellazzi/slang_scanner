class Song < ApplicationRecord
  has_many :sentences
  belongs_to :artist
end
