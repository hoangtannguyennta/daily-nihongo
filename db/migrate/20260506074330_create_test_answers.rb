class CreateTestAnswers < ActiveRecord::Migration[8.1]
  def change
    create_table :test_answers do |t|
      t.references :test_attempt, null: false, foreign_key: true
      t.references :vocabulary, null: false, foreign_key: true
      t.string :selected_answer
      t.string :correct_answer
      t.boolean :correct

      t.timestamps
    end
  end
end
