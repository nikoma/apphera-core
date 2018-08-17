class CreateOrganizationWebservers < ActiveRecord::Migration[5.2]
  def change
    create_table :organization_webservers do |t|
      t.string :type
      t.integer :organization_id

      t.timestamps
    end
    add_index :organization_webservers, :organization_id
  end
end
