class NamedQuery < ActiveRecord::Base
  belongs_to :account
 # attr_accessible :name, :api_partner_id ,:account_id, :description, :query, :placeholders

end
