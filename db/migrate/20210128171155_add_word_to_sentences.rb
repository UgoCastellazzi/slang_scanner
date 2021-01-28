class AddWordToSentences < ActiveRecord::Migration[6.0]
  def change
    add_reference :sentences, :word, null: false, foreign_key: true
  end
end
