class UpdateSongsAndKeywords < ActiveRecord::Migration[6.0]
  def change
    remove_column :songs, :album
    add_column :words, :phonetic_translation, :string
    add_column :words, :definition, :text
  end
end
