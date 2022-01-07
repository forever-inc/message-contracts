# frozen_string_literal: true

RSpec.describe Message::Contracts do
  it "has a version number" do
    expect(Message::Contracts::VERSION).not_to be nil
  end
end
