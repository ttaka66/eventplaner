require 'rails_helper'

describe Event do
	shared_examples 'イベント作成' do
		it "有効な状態であること" do
			expect(build(:group_event)).to be_valid
		end
		it "titleがなければ無効" do
			expect(build(:group_event, title: nil)).not_to be_valid
		end
		it "titleが51文字以上だと無効" do
			expect(build(:group_event, title: 'a'*51)).not_to be_valid
		end
		it "colorがなければ無効" do
			expect(build(:group_event, color: nil)).not_to be_valid
		end
	end
	describe "シングルイベント" do
		it_behaves_like 'イベント作成'
		it "startがなければ無効" do
			expect(build(:single_event, start: nil)).not_to be_valid
		end
		it "startが現在時刻より前の場合無効" do
			expect(build(:single_event, start: 1.hour.ago)).not_to be_valid
		end
		it "endがなければ無効" do
			expect(build(:single_event, end: nil)).not_to be_valid
		end
		it "endがstartの前の場合無効" do
			expect(build(:single_event,
			start: Time.zone.local(2017, 01, 01, 01, 00, 00),
			end: Time.zone.local(2017, 01, 01, 00, 00, 00))).not_to be_valid
		end
	end
	describe "グループイベント" do
		it_behaves_like 'イベント作成'
		# it "owner_idがなければ無効" do
		# 	expect(build(:group_event, owner_id: nil)).not_to be_valid
		# end
	end
	
end
