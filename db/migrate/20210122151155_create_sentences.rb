class CreateSentences < ActiveRecord::Migration[6.0]
  def change
    create_table :sentences do |t|
      t.references :song, null: false, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
