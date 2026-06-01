class CreateLessons < ActiveRecord::Migration[8.1]
  def change
    create_table :lessons do |t|
      t.string :name
      t.integer :number

      t.timestamps
    end
  end
end
