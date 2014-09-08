class CreateApiPartners < ActiveRecord::Migration
  def change
    create_table :api_partners do |t|
      t.string :name
      t.string :token

      t.timestamps
    end
    add_index :api_partners, :name
    add_index :api_partners, :token
  end
end
