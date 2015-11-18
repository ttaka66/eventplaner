require 'rails_helper'

describe Event do
	describe "シングルイベント" do
	end
	describe "グループイベント" do
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
		it "owner_idがなければ無効" do
			expect(build(:group_event, owner_id: nil)).not_to be_valid
		end
	end
	
end
