class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include PublicActivity::StoreController

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  helper_method :can_comment?
  def can_comment?(subject)
    user = subject.user

    # 没登录
    return false unless user_signed_in?
    # 作者本人
    return true if subject.user_id == current_user.id

    return true if user.teachers.ids.include? current_user.id
    return true if user.students.ids.include? current_user.id
    return true if (user.following_users.include? current_user.id) && (current_user.following_users.include? user.id)

    return false
  end
end
