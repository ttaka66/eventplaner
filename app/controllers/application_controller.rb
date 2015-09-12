class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :detect_locale

  #ログイン時のリダイレクト先
  def after_sign_in_path_for(resource)
    calendar_index_path
  end

  private

  # ブラウザの最優先言語を取得しI18n.localeプロパティにセット
  def detect_locale
  	I18n.locale = request.headers['Accept-Language'].scan(/¥A[a-z]{2}/).first
  end
  
end
