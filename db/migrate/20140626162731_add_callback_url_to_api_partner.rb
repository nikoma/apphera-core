class AddCallbackUrlToApiPartner < ActiveRecord::Migration
  def change
    add_column :api_partners, :callback_url, :string
  end
end
