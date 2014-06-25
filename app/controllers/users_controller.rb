class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update,:show,:index]
  before_action :set_user, only: [ :edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :outrange_page, only: :index
  #before_action :correct_user,   only: [:edit, :update]

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page:params[:page],per_page:27)
    render "show_follow"
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page:params[:page],per_page:27)
    render "show_follow"
  end

  def outrange_page
    begin
    n = Integer(params[:page])
    rescue ArgumentError
      n=-1
    rescue TypeError
      n=-1
    end
    if n <= 0
      params[:page] = 1
    end
  end

  def admin_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user.admin?
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page:params[:page],per_page:5)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to @user, notice: 'Welcome to the Sample App!' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, success: 'Profile updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    #@user.destroy
    respond_to do |format|
      format.html { redirect_to users_path,success:'User destroyed' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email,:password,:password_confirmation)
    end
end
