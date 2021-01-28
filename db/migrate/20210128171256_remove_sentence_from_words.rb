class RemoveSentenceFromWords < ActiveRecord::Migration[6.0]
  def change
    remove_reference :words, :sentence, null: false, foreign_key: true
  end
end
