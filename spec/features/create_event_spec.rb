require 'rails_helper'


feature 'イベント作成機能' do

	shared_examples '正常な値を入力' do
		scenario 'DBに保存の後イベント情報を表示' do
			expect{
				fill_in 'タイトル', with: '野球観戦'
				fill_in 'メッセージ', with: '参加者募集'
				fill_in 'カテゴリー', with: 'スポーツ'
				fill_in '場所', with: '名古屋ドーム'
				fill_in '住所', with: '愛知県名古屋市東区大幸南１丁目１ ナゴヤドーム'
				fill_in '費用', with: 2000
				# select 3, from: '候補数'
				find('#timeplan1').fill_in '開始時間', with: '2017/01/01 00:00'
				find('#timeplan1').fill_in '終了時間', with: '2017/01/01 01:00'
				find('#timeplan2').fill_in '開始時間', with: '2017/01/02 00:00'
				find('#timeplan2').fill_in '終了時間', with: '2017/01/02 01:00'
				# find('#timeplan3').fill_in '開始時間', with: '2017/01/03 00:00'
				# find('#timeplan3').fill_in '終了時間', with: '2017/01/03 01:00'
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
			# expect(page).to have_content '17/01/03(火) 00:00'
			# expect(page).to have_content '17/01/03(火) 01:00'
		end
	end

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

			click_on 'Create group event'
		end

		feature 'シングルイベント' do
		end

		feature 'グループイベント' do

			background do
				user2 = create(:user, username: 'user2')
				user3 = create(:user, username: 'user3')
				user4 = create(:user, username: 'user4')
			end

			context '正常な値を入力した場合' do
				it_behaves_like '正常な値を入力'
			end

			context '異常な値入力の後再度正常な値を入力した場合' do
				background do
					expect{click_on '登録する'}.to change(Event, :count).by(0)
					expect(page).to have_content 'イベントに招待'
				end
				scenario '保存に失敗'do
				end
				it_behaves_like '正常な値を入力'
			end

		end

	end

	feature '一般ユーザー' do

		feature 'シングルイベント' do
			scenario 'ログインを要求' do
				visit new_event_path
				expect(current_path).to eq new_user_session_path
				expect(page).to have_content 'Log in'
			end

		end
		feature 'グループイベント' do
			scenario 'ログインを要求' do
				visit new_event_path(act: 'group')
				expect(current_path).to eq new_user_session_path
				expect(page).to have_content 'Log in'
			end
		end
	end

end





