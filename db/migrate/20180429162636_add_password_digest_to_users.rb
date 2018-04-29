class AddPasswordDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    # Add "password_digest" column to DB for bcrypt password hashing
    add_column :users, :password_digest, :string
  end
end
