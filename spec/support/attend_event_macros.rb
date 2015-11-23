module AttendEventMacros
	def attend_event(event_name, plan_no)
		visit root_path

		click_on 'イベントを見る'
		click_on '招待されているイベント'
		click_on event_name
		all(".time_candidate")[plan_no - 1].click_on '私は参加できません'
		find("#entry_timeplan_#{plan_no}").click_on '私は参加できます'

		visit root_path
	end

end