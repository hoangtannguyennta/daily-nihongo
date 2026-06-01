class CreateUserVocabularies < ActiveRecord::Migration[8.1]
  def change
    create_table :user_vocabularies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vocabulary, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
