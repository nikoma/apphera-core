# Application Helper
module ApplicationHelper
  def gravatar_for(user, opts = {})
    opts[:alt] = user.name
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{opts.delete(:size) { 40 }}",
              opts
  end

  def is_active_controller(controller_name, class_name = nil)
    if params[:controller] == controller_name
      class_name == nil ? "active" : class_name
    else
      nil
    end
  end

  def is_active_action(action_name)
    params[:action] == action_name ? "active" : nil
  end

  def display_error_messages(errors, fields=[])
    error_message = []
    fields.each do |field|
      name = field.to_s.split(".").last
      errors.messages[field].each { |error| error_message << "#{name.to_s.humanize} #{error}" } if errors.messages[field]
    end
    if error_message.size > 1
      (error_message.empty?)? '' : "#{error_message.first}"
    else
      (error_message.empty?)? '' : "#{error_message.join(', ')}"
    end
  end

  def bootstrap_class_for flash_type
    case flash_type
      when :success, 'success'
        'alert-success'
      when :error, 'error'
        'alert-error'
      when :alert, 'alert'
        'alert-info'
      when :notice, 'notice'
        'alert-info'
      else
        flash_type.to_s
    end
  end
end
