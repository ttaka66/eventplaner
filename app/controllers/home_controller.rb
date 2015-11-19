class HomeController < ApplicationController
	def index
		unless user_signed_in?
			render template: 'devise/sessions/new'
		end
	end
end
