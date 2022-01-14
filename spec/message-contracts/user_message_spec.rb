# frozen_string_literal: true

RSpec.describe UserMessage do
  context "when user data is in json" do
    let(:user_json_data) { File.read("spec/message-contracts/user_message.json") }
    let(:user_message_field_count) { UserMessage.new({}).keys.count }

    it "can be created from parsing json" do
      user = ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(user_json_data))
      user_field_count = UserMessage.new(user).to_h.count
      expect(user_field_count).to eq(user_message_field_count)
    end
  end

  context "when user data has only three matching keys" do
    let(:user_json_data) { File.read("spec/message-contracts/user_message.json") }
    let(:user_message_field_count) { 3 }

    it "creates a UserMessage with those matching keys only" do
      user = ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(user_json_data))
      user_subset = user.take(user_message_field_count).to_h.with_indifferent_access
      user_hash = UserMessage.new(user_subset).to_h
      expect(user_hash.count).to eq(user_message_field_count)
      expect(user_hash.to_h[:id].nil?).to be false
      expect(user_hash.to_h[:name].nil?).to be false
      expect(user_hash.to_h[:email].nil?).to be false
    end
  end

  context "when user data is in json with an extra kvp" do
    let(:user_json_data) { File.read("spec/message-contracts/user_message.json") }
    let(:user_message_field_count) { UserMessage.new({}).keys.count }

    it "can be created from parsing json without the extra kvp" do
      user = ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(user_json_data))
      user.merge(extra_key: "extra_value")
      user_hash = UserMessage.new(user).to_h
      expect(user_hash.count).to eq(user_message_field_count)
      expect(user_hash[:extra_key].nil?).to be true
    end
  end
end
