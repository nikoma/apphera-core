# Invitation
class Users::InvitationsController < Devise::InvitationsController
  layout 'empty', only: %i[edit update]
  def new
    super
  end

  def create
    super
  end

  def edit
    super
  end

  def update
    super
  end

  protected

  def after_invite_path_for(current_inviter, resource)
    dashboard_url
  end
end