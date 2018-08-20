class AddEmailToOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :email, :string
  end
end
