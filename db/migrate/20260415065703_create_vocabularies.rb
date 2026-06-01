class CreateVocabularies < ActiveRecord::Migration[8.1]
  def change
    create_table :vocabularies do |t|
      t.references :lesson, null: false, foreign_key: true
      t.string :word
      t.string :kana
      t.string :meaning
      t.string :romaji

      t.timestamps
    end
  end
end
