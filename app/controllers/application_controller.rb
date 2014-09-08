class ApplicationController < ActionController::API
  include ActionController::Helpers
  include ActionController::Cookies
  include ActionController::ImplicitRender
  include ActionController::MimeResponds

  include CleanPagination

  before_filter :authenticate_user

  private
  def authenticate_user
    token = request.headers['api-token']
    @current_user = ApiPartner.cached_where(token).first
    unless @current_user
      render :status => 403, :json => {:message => "Invalid token, please contact us at http://www.apphera.com"}
    end
  end

  def validate_account

    @acc = @current_user.accounts.find_by_account_id(request.params['acc'])
    unless @acc
      render :status => 403, :json => {:message => "Invalid Account Access! This incident is tracked with IP "}
    end

  end

  def current_user
    @current_user
  end
end
