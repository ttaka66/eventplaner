require 'rails_helper'

feature 'イベント決定機能' do
	background do
		my_user = create(:user, username: 'my_user')
		sign_in my_user
		user2 = create(:user, username: 'user2')
		user3 = create(:user, username: 'user3')
		user4 = create(:user, username: 'user4')
		invite_event('イベント決定テスト',[user2 ,user3, user4])
		sign_out my_user
		sign_in user2
		attend_event 'イベント決定テスト', 1
		sign_out user2
		sign_in user3
		attend_event 'イベント決定テスト', 1
		sign_out user3
		sign_in my_user
		click_on 'イベントを見る'
		click_on '主催しているイベント'
		click_on 'イベント決定テスト'
	end
	context '参加者(user2,user3)がいる場合' do
		scenario 'イベントの参加者を更新しTimeplan,Entryをすべて削除する' do
			expect{
				find("#deside_btn_for_timeplan_1").click_on '決定する'
				find("#deside_timeplan_1").click_on '決定する'
			}.to change(Timeplan, :count).by(-2).
					and change(Entry, :count).by(-(2*(1+3)))
			expect(page).to have_content '参加者リスト(2人)'
			expect(page).to have_content 'user2'
			expect(page).to have_content 'user3'
			expect(page).not_to have_content 'user4'

		end	
	end
	context '参加者がいない場合' do
		scenario 'DB処理を行わずにアラートを返す' do
			expect{
				find("#deside_btn_for_timeplan_2").click_on '決定する'
				find("#deside_timeplan_2").click_on '決定する'
			}.to change(Timeplan, :count).by(0).
					and change(Entry, :count).by(0)
			expect(page).to have_content '参加者がいないイベントは登録できません'
		end
	end
end