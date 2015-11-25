class UsersController < ApplicationController
  def friends
  	@friends = User.find(params[:id]).friends
  	@user = User.new
  end
  def search
  	word = params[:word]
  	@search_result = User.where('username like ? AND id != ?', "%#{word}%", current_user.id)
  	# render json: @search_result
  end
end
