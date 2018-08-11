class Users::RegistrationsController < Devise::RegistrationsController
  layout 'empty', only: %i[new create]
  def new
    @user = User.new
  end

  def edit
    add_breadcrumb 'Home', :root_path
    add_breadcrumb 'Profile'
  end

  protected

  def after_update_path_for(resource)
    dashboard_url
  end

  def update_resource(resource, params)
    if resource.uid?
      
      resource.update_without_password(params)
     # resource.update(params)

    else
      resource.update_without_password(params)

     # resource.update_with_password(params)

    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :provider, :uid, :locale, :app_id, :is_reseller, organization_attributes: [:id, :name])
  end
  def account_update_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :provider, :uid, :locale, :app_id, :is_reseller, organization_attributes: [:id, :name])
  end
end
