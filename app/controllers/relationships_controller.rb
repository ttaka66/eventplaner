class RelationshipsController < ApplicationController
	before_action :authenticate_user!
	def destroy
		@relationship = Relationship.find(params[:id])
		@relationship.destroy
		redirect_to user_friends_path(current_user)
	end
	def create
		@relationship = Relationship.new(relationship_params)

		@relationship.save
		redirect_to user_friends_path(current_user), notice: t('add friend to friends list')
		
	end

	private
	def relationship_params
		params.require(:relationship).permit(:own_id, :friend_id)
	end
end
