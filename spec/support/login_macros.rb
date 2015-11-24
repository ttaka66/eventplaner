module LoginMacros
	def sign_in(user)
		visit root_path

		fill_in 'メールアドレス', with: user.email
		fill_in 'パスワード', with: user.password
		click_button 'ログイン'

		visit root_path
	end
end