require 'rails_helper'

feature 'チャット機能' do

	scenario "新しいメッセージを送信する" do

		user = create(:user)

		visit root_path

		click_on 'ログイン'
		find('#login_view').fill_in 'Email', with: user.email
		find('#login_view').fill_in 'パスワード', with: user.password
		click_button 'Log in'

		visit root_path

		click_on 

		
	end
	
end

