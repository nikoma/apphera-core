class DropTwitterUsersTable < ActiveRecord::Migration
  def change
    drop_table :twitter_users
  end
end
