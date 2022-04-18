class SessionsController < ApplicationController

  def new
  end

  def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in(user)
        session[:user_id] = @user.id
        flash[:notice] = 'ログインしました'
        redirect_to tasks_path
      else
        flash[:danger] = 'メールアドレスまたはパスワードに誤りがあります'
        render :new
      end
    end

  def destroy
      session.delete(:user_id)
      flash[:notice] = 'ログアウトしました'
      redirect_to new_session_path
  end
end
