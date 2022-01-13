# frozen_string_literal: true

RSpec.describe UserMessage do
  context "when user data is in json with keys that match the UserMessage defined keys" do
    let(:user_json_data) do
      "{\"id\":\"d8ff03f4-c18f-43ed-9a6d-4cf0702a1ee9\",\"name\":\"alex 1\",\"email\":\"alex2@email.com\",\"role\":\"member\",\"membership\":false,\"storage_capacity\":2147483648,\"storage_used\":0,\"tos_agreed\":true,\"stripe_customer_id\":null,\"ambassador_id\":null,\"last_sign_in_at\":\"2022-01-11T14:28:15.454Z\",\"last_sign_in_ip\":\"127.0.0.1\",\"failed_attempts\":0,\"deleted_at\":null,\"created_at\":\"2021-11-01T18:34:10.366Z\",\"updated_at\":\"2022-01-11T14:28:41.729Z\",\"forever_file_id\":null,\"p2p_membership_id\":null,\"slug\":\"alex--51\",\"email_confirmed_at\":null,\"verified_at\":null,\"purged_at\":null,\"abilities\":null,\"tsv_name\":\"'1':2A 'alex':1A\",\"source\":\"Store-Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36\",\"metadata\":null}"
    end
    let(:user_message_field_count) { UserMessage.new({}).keys.count }

    it "can be created from parsing json" do
      user = ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(user_json_data))
      user_field_count = UserMessage.new(user).to_h.count
      expect(user_field_count).to eq(user_message_field_count)
    end
  end

  context "when user data has only three matching keys" do
    let(:user_json_data) do
      "{\"id\":\"d8ff03f4-c18f-43ed-9a6d-4cf0702a1ee9\",\"name\":\"alex 1\",\"email\":\"alex2@email.com\"}"
    end
    let(:user_message_field_count) { 3 }

    it "creates a UserMessage with those matching keys only" do
      user = ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(user_json_data))
      user_hash = UserMessage.new(user).to_h
      expect(user_hash.count).to eq(user_message_field_count)
      expect(user_hash.to_h[:id].nil?).to be false
      expect(user_hash.to_h[:name].nil?).to be false
      expect(user_hash.to_h[:email].nil?).to be false
    end
  end

  context "when user data is in json with an extra kvp" do
    let(:user_json_data) do
      "{\"id\":\"d8ff03f4-c18f-43ed-9a6d-4cf0702a1ee9\",\"name\":\"alex 1\",\"email\":\"alex2@email.com\",\"role\":\"member\",\"membership\":false,\"storage_capacity\":2147483648,\"storage_used\":0,\"tos_agreed\":true,\"stripe_customer_id\":null,\"ambassador_id\":null,\"last_sign_in_at\":\"2022-01-11T14:28:15.454Z\",\"last_sign_in_ip\":\"127.0.0.1\",\"failed_attempts\":0,\"deleted_at\":null,\"created_at\":\"2021-11-01T18:34:10.366Z\",\"updated_at\":\"2022-01-11T14:28:41.729Z\",\"forever_file_id\":null,\"p2p_membership_id\":null,\"slug\":\"alex--51\",\"email_confirmed_at\":null,\"verified_at\":null,\"purged_at\":null,\"abilities\":null,\"tsv_name\":\"'1':2A 'alex':1A\",\"source\":\"Store-Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36\"
        ,\"metadata\":\"null\",\"extra_key\":\"extra_value\"}"
    end
    let(:user_message_field_count) { UserMessage.new({}).keys.count }

    it "can be created from parsing json without the extra kvp" do
      user = ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(user_json_data))
      user_hash = UserMessage.new(user).to_h
      expect(user_hash.count).to eq(user_message_field_count)
      expect(user_hash[:extra_key].nil?).to be true
    end
  end
end
