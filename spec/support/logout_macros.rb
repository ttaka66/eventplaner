module LogoutMacros
	def sign_out(user)
		visit root_path

		click_on "#{user.username}"
		click_on 'ログアウト'

		visit root_path
	end
end