class AddGeniusInfoToArtists < ActiveRecord::Migration[6.0]
  def change
    add_column :artists, :image, :string
    add_column :artists, :genius_id, :string
    add_column :artists, :genius_url, :string
  end
end
