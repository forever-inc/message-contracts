# frozen_string_literal: true

require "message/contracts/base_message"

# top level documentation
class UserMessage
  include ActiveModel::Model
  include BaseMessage

  KEYS = %i[id name email].freeze
  attr_accessor(*KEYS)

  def initialize(attributes = nil)
    super(attributes.slice(*KEYS))
  end
end
