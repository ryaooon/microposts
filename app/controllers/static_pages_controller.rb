class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      if params[:search]
        @feed_items = Micropost.search(params[:search])
      else
        @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
      end
    end
  end
end
