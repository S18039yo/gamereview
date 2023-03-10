# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :check_customer_login

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  #会員としてログインしている場合にアカウントをログアウトさせる
  def check_customer_login
    if customer_signed_in?
      sign_out(:customer)
    end 
  end

  #ログイン後管理者Topページへ
  def after_sign_in_path_for(resource)
    admins_root_path
  end

  #ログアウト後管理者ログインページへ
  def after_sign_out_path_for(resource)
    new_admin_session_path
  end
  
end
