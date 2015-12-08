module CreateGroupEventMacros
	def invite_event(eventname, invitees)
		visit root_path

		click_on 'イベントに招待する'
		fill_in 'タイトル', with: eventname
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
		invitees.each do |i|
			click_on i.username
		end

		click_on '登録する'

		visit root_path
	end

end