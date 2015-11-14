require 'rails_helper'

describe Comment do
	it "bodyがあれば有効" do
		expect(build(:comment)).to be_valid
	end
  it "bodyがなければ無効" do
  	expect(build(:comment, body: nil)).not_to be_valid
	end	
  it "bodyが200文字以内であれば有効" do
  	expect(build(:comment, body: 'a'*200)).to be_valid
	end
  it "bodyが200文字より多い場合無効" do
  	expect(build(:comment, body: 'a'*201)).not_to be_valid
	end
end
