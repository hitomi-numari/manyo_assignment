class ApplicationController < ActionController::Base
  include SessionsHelper
  private
  def redirect_if_login
    redirect_to tasks_path if logged_in?
  end

end
