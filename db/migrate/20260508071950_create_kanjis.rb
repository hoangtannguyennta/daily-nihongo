class CreateKanjis < ActiveRecord::Migration[8.1]
  def change
    create_table :kanjis do |t|
      t.string :character
      t.string :onyomi
      t.string :kunyomi
      t.string :meaning
      t.integer :stroke_count
      t.string :jlpt_level

      t.timestamps
    end
  end
end
