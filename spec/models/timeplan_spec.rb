require 'rails_helper'
describe Timeplan do
	it "有効な状態であること" do
		expect(build(:timeplan)).to be_valid
	end
	it "startがなければ無効" do
		expect(build(:timeplan, start: nil)).not_to be_valid
	end
	it "startが現在時刻より前の場合無効" do
		expect(build(:timeplan, start: 1.hour.ago)).not_to be_valid
	end
	it "endがなければ無効" do
		expect(build(:timeplan, end: nil)).not_to be_valid
	end
	it "endがstartの前の場合無効" do
		expect(build(:timeplan,
			start: Time.zone.local(2017, 01, 01, 01, 00, 00),
			end: Time.zone.local(2017, 01, 01, 00, 00, 00))).not_to be_valid
	end
end
