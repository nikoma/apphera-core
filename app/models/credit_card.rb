class CreditCard < ActiveRecord::Base
  # model used by stripe.com
  belongs_to :user
  #attr_accessible :card_zip, :card_cvc, :month_expiration, :year_expiration, :stripe_customer_id, :user_id, :card_type

end
