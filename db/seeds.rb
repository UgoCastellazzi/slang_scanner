require 'net/http'
require 'uri'

def cleaning
  puts "Cleaning database..."
  Sentence.destroy_all
  Song.destroy_all
  Word.destroy_all
  Artist.destroy_all
end

cleaning

Word.create(name: "moula")
Word.create(name: "kishta")
Word.create(name: "keuf")