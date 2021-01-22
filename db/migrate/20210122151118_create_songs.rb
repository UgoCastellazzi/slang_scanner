class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.references :artist, null: false, foreign_key: true
      t.string :name
      t.date :release_date
      t.string :album
      t.integer :genius_views

      t.timestamps
    end
  end
end
