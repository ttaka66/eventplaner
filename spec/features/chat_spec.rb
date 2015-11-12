require 'rails_helper'

feature 'チャット機能' do

	scenario "新しいメッセージを送信する" do

		user = create(:user)
		event = create(:group_event)

		visit root_path

		click_on 'ログイン'
		find('#login_view').fill_in 'Email', with: user.email
		find('#login_view').fill_in 'パスワード', with: user.password
		click_button 'Log in'

		visit event_path(event)

		expect{
			fill_in 'msgbody', with: '新しいメッセージ'
			click_on '送信'
		}.to change(Comment, :count).by(1)

		expect(page).to have_content "#{user.username}さんからメッセージが送られました"

		expect(page).to have_content '新しいメッセージ'

		
	end
	
end

