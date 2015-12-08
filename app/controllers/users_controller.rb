class UsersController < ApplicationController
	before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update]
  before_action :confirm_account, only: [:edit, :update, :cancel_account, :friends]

	def edit
	end
	def update
		if @user.update(user_params)
      redirect_to root_path, notice: t('a profile is changed')
    else
      render action: 'edit'
    end
	end
  def cancel_account
  end
  def friends
  	@friends = User.find(params[:id]).friends.page(params[:friends_page]).per(10)
  	@user = User.new
  end
  def search
  	word = params[:word]
  	@search_result = User.where('username like ? AND id != ?', "%#{word}%", current_user.id).limit(10)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
  	params.require(:user).permit(:username, :avater)
  end

  def confirm_account
    own_user = User.find(params[:id])
    unless own_user == current_user
      redirect_to root_path, alert: t("can't show other's friends list")
    end
  end
  	
end
