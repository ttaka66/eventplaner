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

				scenario '新しいイベントを作成する', js: true do
					expect{
						click_on 'Create group event'
						fill_in 'タイトル', with: '野球観戦'
						fill_in 'メッセージ', with: '参加者募集'
						fill_in 'カテゴリー', with: 'スポーツ'
						fill_in '場所', with: '名古屋ドーム'
						fill_in '住所', with: '愛知県名古屋市東区大幸南１丁目１ ナゴヤドーム'
						fill_in '費用', with: 2000
						select 3, from: '候補数'
						find('#timeplan1').fill_in '開始時間', with: '2017/01/01 00:00'
						find('#timeplan1').fill_in '終了時間', with: '2017/01/01 01:00'
						find('#timeplan2').fill_in '開始時間', with: '2017/01/02 00:00'
						find('#timeplan2').fill_in '終了時間', with: '2017/01/02 01:00'
						find('#timeplan3').fill_in '開始時間', with: '2017/01/03 00:00'
						find('#timeplan3').fill_in '終了時間', with: '2017/01/03 01:00'
						fill_in 'invitees1', with: 'user2'
						fill_in 'invitees2', with: 'user3'
						fill_in 'invitees3', with: 'user4'
						click_on '登録する'
					}.to change(Event, :count).by(1).and change(Timeplan, :count).by(2).
					and change(Entry, :count).by(2*(3+1))
					expect(page).to have_content '野球観戦'
					expect(page).to have_content '参加者募集'
					expect(page).to have_content '参加者募集'
					expect(page).to have_content '愛知県名古屋市東区大幸南１丁目１ ナゴヤドーム'
					expect(page).to have_content '17/01/01(日) 00:00'
					expect(page).to have_content '17/01/01(日) 01:00'
					expect(page).to have_content '17/01/02(月) 00:00'
					expect(page).to have_content '17/01/02(月) 01:00'
					expect(page).to have_content '17/01/03(火) 00:00'
					expect(page).to have_content '17/01/03(火) 01:00'

				end
			end

		end

	end

	feature '一般ユーザー' do
	end


end

