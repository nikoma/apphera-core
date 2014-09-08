class AddAccountIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :account_id, :integer
    add_index :items, :account_id
  end
end
