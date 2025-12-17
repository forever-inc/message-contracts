# frozen_string_literal: true

RSpec.describe BoxMessage do
  let(:box_json_data) { File.read("spec/fixtures/box_message.json") }

  context "when box data is in json" do
    let(:box_message_field_count) { described_class.new({}).keys.count }

    it "can be created from parsing json" do
      box = ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(box_json_data))
      box_field_count = described_class.new(box).to_h.count
      expect(box_field_count).to eq(box_message_field_count)
    end
  end

  context "when box data has only three matching keys" do
    let(:box_message_field_count) { 3 }

    it "creates a BoxMessage with those matching keys only" do
      box = ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(box_json_data))
      box_subset = box.take(box_message_field_count).to_h.with_indifferent_access
      box_hash = described_class.new(box_subset).to_h
      expect(box_hash.count).to eq(box_message_field_count)
      expect(box_hash.to_h[:email].nil?).to be false
    end
  end

  context "when box data is in json with an extra kvp" do
    let(:box_message_field_count) { described_class.new({}).keys.count }

    it "can be created from parsing json without the extra kvp" do
      box = ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(box_json_data))
      box.merge(extra_key: "extra_value")
      box_hash = described_class.new(box).to_h
      expect(box_hash.count).to eq(box_message_field_count)
      expect(box_hash[:extra_key].nil?).to be true
    end
  end
end
