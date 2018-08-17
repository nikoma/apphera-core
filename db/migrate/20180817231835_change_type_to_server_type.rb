class ChangeTypeToServerType < ActiveRecord::Migration[5.2]
  def change
    rename_column :organization_webservers, :type, :server_type
  end
end
