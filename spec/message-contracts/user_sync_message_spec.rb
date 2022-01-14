# frozen_string_literal: true

RSpec.describe UserSyncMessage do
  context "when user sync data is in json" do
    let(:single_user_json) { File.read("spec/message-contracts/user_message.json") }
    let(:multiple_user_array) do
      (1..5).map do
        UserMessage.new ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(single_user_json))
      end
    end
    let(:user_sync_message_json) { described_class.new(multiple_user_array).to_json }
    let(:user_message_field_count) { UserMessage.new({}).keys.count }

    it "can be created from parsing json" do
      payload = ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(user_sync_message_json))
      user_sync_message = described_class.new(payload)
      expect(user_sync_message.users.count).to eq(multiple_user_array.count)
      user_sync_message.users.each do |user|
        expect(user.keys.count).to eq(user_message_field_count)
      end
    end
  end
end
