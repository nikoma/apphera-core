# Devise Overright Helper
module DeviseHelper
  def devise_error_messages!
    errors = resource.errors.full_messages
    if errors.any?
      flash.now[:error] = errors.join
    end
    return ''
  end
end
