class User < ApplicationRecord
  has_paper_trail
 # belongs_to :reseller
  #belongs_to :account
  #has_one :credit_card
  has_many :subscriptions
  has_many :history_items
  has_many :authentications
  #before_save :ensure_authentication_token
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,:token_authenticatable,
        omniauth_providers: %i[facebook twitter google_oauth2 microsoft_live]
  # Setup accessible (or protected) attributes for your model
  #attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :reseller_id, :is_reseller, :referred_by, :password_digest

  validates :email, :presence => true

  def affiliate?
    self.is_reseller || false
  end


  def reseller?
    puts self.reseller.present?
    self.reseller.present?
  end


  class << self
    def find_for_oauth(auth)
      email = auth.info.email.present? ? auth.info.email : User.dummy_email(auth)
      user = User.where(uid: auth.uid, provider: auth.provider).first
      user2 = User.find_by(email: email)
      if user.nil? && user2.nil?
        password = Devise.friendly_token[0, 20]
        user = User.new({
          uid: auth.uid, provider: auth.provider,
          email: email,
          password: password, temp_password: password
        })
        user.build_organization(name: "#{auth.uid}-#{auth.provider}")
        user.save
      elsif user2.present?
        user2.update_attributes(uid: auth.uid, provider: auth.provider)
        user = user2
      end
      user
    end

    def new_with_session(params, session)
      super.tap do |user|
        data = session['devise.facebook_data']
        if data && session['devise.facebook_data']['extra']['raw_info']
          user.email = data['email'] unless user.email?
        end
      end
    end
  end
end
