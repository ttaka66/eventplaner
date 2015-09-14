class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :detect_locale

  # deviseコントローラーにconfigure_permitted_parametersメソッドを追加
  before_action :configure_permitted_parameters, if: :devise_controller?

  #ログイン時のリダイレクト先
  def after_sign_in_path_for(resource)
    calendar_index_path
  end



  private

  # ブラウザの最優先言語を取得しI18n.localeプロパティにセット
  def detect_locale
  	I18n.locale = request.headers['Accept-Language'].scan(/¥A[a-z]{2}/).first
  end

  # 許可するパラメーターの設定
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :avatar, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :avatar, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :avatar, :email, :password, :password_confirmation, :current_password) }
  end
  
end
