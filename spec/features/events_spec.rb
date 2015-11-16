require 'rails_helper'

feature 'イベント' do

	feature 'ログインユーザー' do

		background do

			my_user = create(:user)
			event = create(:group_event)

			visit root_path

			click_on 'ログイン'
			find('#login_view').fill_in 'Email', with: my_user.email
			find('#login_view').fill_in 'パスワード', with: my_user.password
			click_button 'Log in'

			visit root_path

		end

		feature 'イベントの作成' do

			feature 'シングルイベント' do
			end

			feature 'グループイベント' do

				background do
					user2 = create(:user, username: 'user2')
					user3 = create(:user, username: 'user3')
					user4 = create(:user, username: 'user4')
				end

				scenario '新しいイベントを作成する' do
					click_on 'Create group event'
					fill_in 'タイトル', with: '野球観戦'
					fill_in 'メッセージ', with: '参加者募集'
					fill_in 'カテゴリー', with: 'スポーツ'
					fill_in '場所', with: '名古屋ドーム'
					fill_in '住所', with: '愛知県名古屋市東区大幸南１丁目１ ナゴヤドーム'
					fill_in '費用', with: 2000
					select '2016/01/01/12/12', :from => 'event_timeplans_attributes_0_start'
					select '2016/01/01/13/00', :from => 'event_timeplans_attributes_0_end'
					find('#invitees1').fill_in
					find('#invitees2').fill_in
					find('#invitees3').fill_in

				end
			end

		end

	end

	feature '一般ユーザー' do
	end


end

