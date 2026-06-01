class AddPriorityToVocabularies < ActiveRecord::Migration[8.1]
  def change
    add_column :vocabularies, :priority, :integer
  end
end
