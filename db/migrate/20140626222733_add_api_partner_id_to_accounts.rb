class AddApiPartnerIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :api_partner_id, :integer
    add_index :accounts, :api_partner_id
  end
end
