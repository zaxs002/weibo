class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def new

  end

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |f|
      f.html { redirect_to @user }
      f.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |f|
      f.html { redirect_to @user }
      f.js
    end
  end
end