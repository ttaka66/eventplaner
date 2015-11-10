class CommentsController < ApplicationController

	def index
		@event = Event.find(params[:event_id])
		@comments = @event.comments.page(params[:comment_page]).per(5).
      order(created_at: :desc)
    # ページ更新(Ajax)の場合 テンプレート：index.js.erb

    # 新しいコメントを表示の場合 テンプレート：index.html.erb(javascriptのloadから読む為レイアウトなし)	
    render layout: false
	end

	def create
		@comment = Comment.new(comment_params)
		@comment.save!
		render json: @comment
	end

	private

	def comment_params
		params.require(:comment).permit(:user_id, :event_id, :body)
	end

end
