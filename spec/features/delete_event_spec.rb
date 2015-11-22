require 'rails_helper'


feature 'イベント削除機能' do

	background do
		my_user = create(:user, username: 'my_user')
		sign_in my_user
	end

	

	feature 'シングルイベント' do
		background do
			create_event('イベント削除テスト')
			click_on 'イベントを見る'
			click_on 'すべてのイベント'
			click_on 'イベント削除テスト'
		end
		scenario 'イベントを削除する' do
			expect{
				click_on 'イベントを削除する'
			}.to change(Event, :count).by(-1).
				and change(Timeplan, :count).by(0).
				and change(Entry, :count).by(0)
		end
	end

	feature 'グループイベント' do
		background do
			user2 = create(:user, username: 'user2')
			user3 = create(:user, username: 'user3')
			user4 = create(:user, username: 'user4')
			invite_event('イベント削除テスト', [user2 ,user3, user4])
			click_on 'イベントを見る'
			click_on '主催しているイベント'
			click_on 'イベント削除テスト'
		end
		scenario 'イベントを削除しTimeplan,Entryを削除する' do
			expect{
				click_on 'イベントを削除する'
			}.to change(Event, :count).by(-1).
				and change(Timeplan, :count).by(-2).
				and change(Entry, :count).by(-(2*(1+3)))
		end
	end

end
