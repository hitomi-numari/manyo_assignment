module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    redirect_to new_session_path unless current_user.present?
  end

  def authorize
    redirect_to sessions_new_path, notice: 'ログインが必要な機能です' unless logged_in?
  end

  def ensure_correct_task
    @task = Task.find_by(id: params[:id])
    if current_user.id != @task.user_id
      flash[:danger] = "権限がありません"
      redirect_to tasks_path
    end
  end

  def ensure_correct_user
    @user = User.find_by(id: params[:id])
    if current_user.id != @user.id
      flash[:danger] = "権限がありません。ログインしてください。"
      redirect_to tasks_path
    end
  end

end
