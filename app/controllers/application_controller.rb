class ApplicationController < ActionController::Base
  include SessionsHelper
  private
  def redirect_if_login
    if logged_in?
      flash[:danger] = "ログアウトしてください"
      redirect_to tasks_path
    end
  end

end
