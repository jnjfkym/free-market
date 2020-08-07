class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  #deviseのストロングパラメーター↓↓
  before_action :configure_permitted_paramaters, if: :devise_controller?
  before_action :authenticate_user!

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.basic[:user_name] && password == Rails.application.credentials.basic[:password]
    end
  end
  
  #ストロングパラメーターの内容
  def configure_permitted_paramaters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :first_name_reading, :last_name, :last_name_reading, :birthday])
  end

  #新規登録・ログイン後トップページからマイページへリダイレクト
  def after_sign_in_path_for(resource)
    user_path(resource)
  end

end