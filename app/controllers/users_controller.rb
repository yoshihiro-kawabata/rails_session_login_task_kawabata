class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user,  only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show]

  def new
    @user = User.new
  end

  def create
      @user = User.new(user_params)
      if @user.save
        log_in(@user)
        session[:user_id] = @user.id
        redirect_to tasks_path
        flash[:notice] = 'アカウントを登録しました'
      else
        render :new
      end
  end

  def show
  end

  def edit
  end

  def update
      check_user = user_params
      if check_user[:password] == ""
        check_user[:password] = nil
        @user.update(check_user)
         render :edit
      else
        if @user.update(user_params)
            redirect_to user_path(@user.id)
            flash[:notice] = 'アカウントを更新しました'
        else
            render :edit
       end
      end
  end
  
  def destroy
      @user.destroy
      redirect_to new_session_path
  end
  

  private
  def set_user
      @user = User.find(params[:id])
    end

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
def correct_user
      @user = User.find(params[:id])
      redirect_to current_user unless current_user?(@user)
  end
end