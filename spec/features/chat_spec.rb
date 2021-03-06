require 'rails_helper'

feature 'チャット機能' do


	background do

		my_user = create(:user)
		event = create(:group_event)

		sign_in my_user

		visit event_path(event)
	end

	context "有効な属性の場合" do

		scenario "保存されアラート(新しいメッセージ)が表示される" do

			expect{
				fill_in 'msgbody', with: '新しいメッセージ'
				click_on '送信'
				}.to change(Comment, :count).by(1)

			# Websocketはpoltergeistでテストできない
			# expect(page).to have_content "#{user.username}さんからメッセージが送られました"

			expect(page).to have_content '新しいメッセージ'
		end

	end

	context "無効な属性の場合" do

		scenario "保存せずにアラート(Bodyを入力してください)が表示される" do
			expect{
				fill_in 'msgbody', with: ''
				click_on '送信'
				}.to change(Comment, :count).by(0)

			# Websocketはpoltergeistでテストできない
			expect(page).to have_content "Bodyを入力してください"

		end

	end

end
