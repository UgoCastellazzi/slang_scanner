class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.date :release_date
      t.string :image
      t.references :artist, null: false, foreign_key: true
      t.string :genius_id
      t.string :genius_url

      t.timestamps
    end
  end
end
