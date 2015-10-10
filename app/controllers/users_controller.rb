class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  load_and_authorize_resource

  def index
    if search_params
      @users = User.search(search_params)
    else
      @users = User.order(updated_at: :DESC).includes(:role)
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'Updated user information successfully.'
    else
      render action: 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :role_id).delete_if { |_k, v| v.empty? }
  end

  def search_params
    params.require(:search).permit(:email) if params[:search]
  end
end
