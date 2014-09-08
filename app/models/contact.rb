class Contact < ActiveRecord::Base

  # legacy left over from models in web site (contact form)

  attr_accessible :city, :comment, :country, :email, :name, :phone, :subject
  validates :email, :presence => true
  validates :comment, :presence => true

end
