class Users::SessionsController < Devise::SessionsController
  def new
    @user = User.new
  	render layout: 'empty'
  end
end