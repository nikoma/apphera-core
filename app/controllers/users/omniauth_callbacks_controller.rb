# Omnniauth Callbacks Controller
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_from :facebook
  end

  def twitter
    callback_from :twitter
  end

  def google_oauth2
    callback_from :google_oauth2
  end

  def microsoft_live
    callback_from :microsoft_live
  end

  def linkedin
    callback_from :linkedin
  end

  def revoke_login
    user = User.where(uid: params[:uid], provider: params[:provider]).first
    user.update_attributes(uid: nil,provider: nil) if user.present?
    redirect_to edit_user_registration_path
  end

  private

  def callback_from(provider)
    provider = provider.to_s
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      if is_navigational_format?
        set_flash_message(:notice, :success, kind: provider.capitalize)
      end
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
