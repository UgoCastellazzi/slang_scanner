# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_07_161954) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.string "genius_id"
    t.string "genius_url"
  end

  create_table "sentences", force: :cascade do |t|
    t.bigint "song_id", null: false
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "word_id", null: false
    t.index ["song_id"], name: "index_sentences_on_song_id"
    t.index ["word_id"], name: "index_sentences_on_word_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "name"
    t.date "release_date"
    t.integer "genius_views"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.string "genius_id"
    t.string "genius_url"
    t.bigint "artist_id", null: false
    t.index ["artist_id"], name: "index_songs_on_artist_id"
  end

  create_table "words", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phonetic_translation"
    t.text "definition"
  end

  add_foreign_key "sentences", "songs"
  add_foreign_key "sentences", "words"
  add_foreign_key "songs", "artists"
end
