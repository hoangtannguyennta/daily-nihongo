class CreateKanas < ActiveRecord::Migration[8.1]
  def change
    create_table :kanas do |t|
      t.string :character
      t.string :romaji
      t.string :kind

      t.timestamps
    end
  end
end
