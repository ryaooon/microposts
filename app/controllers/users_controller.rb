class UsersController < ApplicationController
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

 # フォローしているユーザの表示
  def followings
    @followings = User.find(params[:id]).following_users
    #binding.pry
    #@following = Relationship.where(follower_id: params[:id])
    # フォローしているユーザを検索
    #@following_user = User.find(@following.ids)
    #@following = @following_user #Relationship.where(follower_id: params[:id])
  end
  
  # フォローされているユーザを表示
  def followers
    # .follower_usersでフォローされているユーザの集まりを取得可能
    # app/models/user.rb参考
    @followers = User.find(params[:id]).follower_users
  end
  

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end

