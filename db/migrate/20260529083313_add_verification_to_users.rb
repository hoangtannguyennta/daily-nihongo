class AddVerificationToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :verified, :boolean
    add_column :users, :verification_token, :string
  end
end
