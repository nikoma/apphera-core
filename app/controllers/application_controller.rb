class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # HTTP_OK = 200
  # HTTP_CREATED = 201
  # HTTP_BAD_REQUEST = 400
  # HTTP_UNAUTHORIZED = 401
  # HTTP_NOT_FOUND = 404
  # HTTP_METHOD_NOT_ALLOWED = 405
  # HTTP_INTERNAL_SERVER_ERROR = 500
  # include CleanPagination

  protect_from_forgery with: :exception

  # before_action :chat_rooms
  around_action :catch_not_found

  # def chat_rooms
  #   @chat_rooms = ChatRoom.all
  # end
  protected

  def after_sign_in_path_for(resource)
    dashboard_url
  end

  private

 
  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, flash: { error: 'Record not found.' }
  end

  # def only_admin_access
  #   unless current_user.is_admin?
  #     redirect_to dashboard_url, flash: {error: 'Access Denied'}
  #   end
  # end

  # def only_company_n_admin_access
  #   unless current_user.is_admin? || current_user.company_id? || current_user.organization_id?
  #     redirect_to dashboard_url, flash: { error: 'Access Denied' }
  #   end
  # end
end







  # before_filter :authenticate_user

  # private
  # def authenticate_user
  #   token = request.headers['api-token']
  #   @current_user = ApiPartner.cached_where(token).first
  #   unless @current_user
  #     render :status => 403, :json => {:message => "Invalid token, please contact us at http://www.apphera.com"}
  #   end
  # end

  # def validate_account

  #   @acc = @current_user.accounts.find_by_account_id(request.params['acc'])
  #   unless @acc
  #     render :status => 403, :json => {:message => "Invalid Account Access! This incident is tracked with IP "}
  #   end

  # end

  # def current_user
  #   @current_user
  # end
