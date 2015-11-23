module CreateGroupEventMacros
	def create_event(eventname)
		visit root_path
		click_on 'イベントを作成する'
		fill_in 'タイトル', with: eventname
		fill_in '場所', with: '名古屋ドーム'
		fill_in '住所', with: '愛知県名古屋市東区大幸南１丁目１ ナゴヤドーム'
		fill_in '費用', with: 2000
		fill_in '開始時間', with: '2017/01/01 00:00'
		fill_in '終了時間', with: '2017/01/01 01:00'
		click_on '登録する'
		visit root_path
	end
end