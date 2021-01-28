class Song < ApplicationRecord
  has_many :sentences
  belongs_to :artist

  has_many :words, through: :sentences
end
