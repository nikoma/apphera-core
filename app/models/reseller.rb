class Reseller < ActiveRecord::Base
  belongs_to :reseller_category
  has_many :reseller_commissions
  has_many :accounts
  has_many :users
  validates :first_name, :presence => true
  validates :street, :presence => true
  validates :city, :presence => true
  validates :name, :presence => true
  validates :email, :uniqueness => true, :presence => true
  validates :phone, :presence => true, :uniqueness => true
  attr_accessible :company, :first_name, :name, :street, :city, :sub_domain, :logo, :state, :postalcode, :email, :phone, :website, :twitter, :facebook, :country_code_id
  accepts_nested_attributes_for :users


  def self.all_orgs(reseller_id)
    reseller = where("id =  ?", reseller_id).first
    acct = reseller.accounts
    acct.each do |a|
      begin
        @allorgs << a
      rescue
      end
    end
  end

  def self.current_id=(id)
    Thread.current[:reseller_id] = id
  end

  def self.current_id
    Thread.current[:reseller_id]
  end


end
