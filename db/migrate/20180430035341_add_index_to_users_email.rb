class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    # Make sure email column has all unique values
    add_index :users, :email, unique: true
  end
end
