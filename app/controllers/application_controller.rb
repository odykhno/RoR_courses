class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def current_user
    @user ||= User.find_by(id: session['user_id'])
  end

  def authenticate!
    render(file: 'public/401.html', status: :unauthorized) if current_user.blank?
  end
end
