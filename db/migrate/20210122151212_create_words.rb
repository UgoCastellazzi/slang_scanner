class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string :name
      t.references :sentence, null: false, foreign_key: true

      t.timestamps
    end
  end
end
