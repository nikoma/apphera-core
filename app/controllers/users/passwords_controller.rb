class Users::PasswordsController < Devise::PasswordsController
  layout 'empty', only: [:edit, :update, :new, :create]
  def new
    @user = User.new
    render layout: 'empty'
  end

  def create
    super
  end

  def edit
    super
  end

  def update
    super
    # @user = User.find(current_user.id)
    # email_changed = @user.email != params[:user][:email]
    # is_facebook_account = !@user.provider.blank?

    # successfully_updated = if !is_facebook_account
    #   @user.update_with_password(params[:user])
    # else
    #   @user.update_without_password(params[:user])
    # end

    # if successfully_updated
    #   # Sign in the user bypassing validation in case his password changed
    #   sign_in @user, :bypass => true
    #   redirect_to root_path
    # else
    #   render "edit"
    # end
  
  end

  protected

  def after_update_path_for(resource_or_scope)
    dashboard_url
  end

end