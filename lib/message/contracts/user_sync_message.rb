# frozen_string_literal: true

# top level documentation
class UserSyncMessage < BaseMessage
  def keys
    %i[users].freeze
  end

  def initialize(users)
    users = { users: users } if users.is_a?(Array)
    super(users)
  end
end
