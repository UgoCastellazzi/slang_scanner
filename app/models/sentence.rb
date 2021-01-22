class Sentence < ApplicationRecord
  has_many :words
  belongs_to :song
end
