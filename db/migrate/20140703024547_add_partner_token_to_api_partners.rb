class AddPartnerTokenToApiPartners < ActiveRecord::Migration
  def change
    add_column :api_partners, :partner_token, :string
  end
end
