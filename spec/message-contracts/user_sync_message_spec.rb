# frozen_string_literal: true

RSpec.describe UserSyncMessage do
  context "when user sync data is in json" do
    let(:single_user_json) do
      "{\"id\":\"d8ff03f4-c18f-43ed-9a6d-4cf0702a1ee9\",\"name\":\"alex 1\",\"email\":\"alex2@email.com\",\"role\":\"member\",\"membership\":false,\"storage_capacity\":2147483648,\"storage_used\":0,\"tos_agreed\":true,\"stripe_customer_id\":null,\"ambassador_id\":null,\"last_sign_in_at\":\"2022-01-11T14:28:15.454Z\",\"last_sign_in_ip\":\"127.0.0.1\",\"failed_attempts\":0,\"deleted_at\":null,\"created_at\":\"2021-11-01T18:34:10.366Z\",\"updated_at\":\"2022-01-11T14:28:41.729Z\",\"forever_file_id\":null,\"p2p_membership_id\":null,\"slug\":\"alex--51\",\"email_confirmed_at\":null,\"verified_at\":null,\"purged_at\":null,\"abilities\":null,\"tsv_name\":\"'1':2A 'alex':1A\",\"source\":\"Store-Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36\",\"metadata\":null}"
    end
    let(:multiple_user_array) do
      (1..5).map do
        UserMessage.new ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(single_user_json))
      end
    end
    let(:user_sync_message_json) { UserSyncMessage.new(multiple_user_array).to_json }
    let(:user_message_field_count) { UserMessage.new({}).keys.count }

    it "can be created from parsing json" do
      payload = ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(user_sync_message_json))
      user_sync_message = UserSyncMessage.new(payload)
      expect(user_sync_message.users.count).to eq(multiple_user_array.count)
      user_sync_message.users.each do |user|
        expect(user.keys.count).to eq(user_message_field_count)
      end
    end
  end
end
