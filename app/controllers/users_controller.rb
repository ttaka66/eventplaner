class UsersController < ApplicationController
	before_action :authenticate_user!
  def friends
  	own_user = User.find(params[:id])
  	unless own_user == current_user
  		redirect_to root_path, alert: t("can't show other's friends list")
  	end
  	@friends = User.find(params[:id]).friends
  	@user = User.new
  end
  def search
  	word = params[:word]
  	@search_result = User.where('username like ? AND id != ?', "%#{word}%", current_user.id)
  end
end
