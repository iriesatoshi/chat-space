require 'rails_helper'
describe Message do
  describe '#create' do
    it "is invalid without a group_id" do
      message = build(:message, group_id: "")
      message.valid?
      expect(message.errors[:group_id]).to include("を入力してください")
    end
    it "is invalid without a user_id" do
      message = build(:message, user_id: "")
      message.valid?
      expect(message.errors[:user_id]).to include("を入力してください")
    end
    it "is invalid without body or image" do
      message = build(:message, body: "", image: "")
      message.valid?
      expect(message.errors[:body_or_image]).to include("を入力してください")
    end
    it "is valid with a body" do
      message = build(:message, image: "")
      expect(message).to be_valid
    end
    it "is valid with a image" do
      message = build(:message, body: "")
      expect(message).to be_valid
    end
    it "is valid with a image and body" do
      message = build(:message)
      expect(message).to be_valid
    end
  end
end
