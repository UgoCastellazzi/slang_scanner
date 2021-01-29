class AddGeniusInfoToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :image, :string
    add_column :songs, :genius_id, :string
    add_column :songs, :genius_url, :string
  end
end
