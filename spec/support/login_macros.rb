module LoginMacros
	def sign_in(user)
		visit root_path

		fill_in 'Email', with: user.email
		fill_in 'パスワード', with: user.password
		click_button 'Log in'

		visit root_path
	end
end