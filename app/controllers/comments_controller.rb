class CommentsController < ApplicationController

	def index
		@event = Event.find(params[:event_id])
		@comments = @event.comments.page(params[:comment_page]).per(5).
      order(created_at: :desc)
	end

	def create
		@comment = Comment.new(comment_params)
		@comment.save
	end

	private

	def comment_params
		params.require(:comment).permit(:user_id, :event_id, :body)
	end

end
