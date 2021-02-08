class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:relationship][:follower_id])
    #binding.pry
    # 現在エラー箇所　undefined method `follow' for #<User:0x00007f68b99bcde0> Did you mean? follow!
    current_user.follow(@user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @user = User.find(params[:relationship][:follower_id])
    current_user.unfollow(@user)
    redirect_back(fallback_location: root_path)
  end
end