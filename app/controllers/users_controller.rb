class UsersController < ApplicationController
 before_action :logged_in_user, only: [:edit, :update]
 
    
 def show # 追加
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
 end


 def new
    @user = User.new
 end


 def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
 end

 def edit
    # @user = User.find(params[:id])
    unless @user = current_user
      redirect_to user_uerl(@user)
    end
 end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Update your profile"
      redirect_to user_url(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
  def check_user
    @user = User.find(params[:id])
    if (current_user != @user)
     redirect_to root_path
    end
  end
end

  
