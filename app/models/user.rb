class User < ActiveRecord::Base
  has_paper_trail
  belongs_to :reseller
  belongs_to :account
  has_one :credit_card
  has_many :subscriptions
  has_many :history_items
  has_many :authentications
  #before_save :ensure_authentication_token
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :reseller_id, :is_reseller, :referred_by, :password_digest

  validates :name, :presence => true

  def affiliate?
    self.is_reseller || false
  end


  def reseller?
    puts self.reseller.present?
    self.reseller.present?
  end


  def apply_omniauth(auth)
    # In previous omniauth, 'user_info' was used in place of 'raw_info'
    self.email = auth['extra']['raw_info']['email']
    self.name = auth['extra']['raw_info']['nickname']
    if auth['provider'] == "twitter"
      self.email ="#{auth.info.nickname}@twitter.com"
    end
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  end

end
