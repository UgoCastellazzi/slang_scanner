class RemoveArtistFromSongs < ActiveRecord::Migration[6.0]
  def change
    remove_column :songs, :artist_id
    add_reference :songs, :album, index: true
  end
end
