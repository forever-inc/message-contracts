# frozen_string_literal: true

class UserSyncMessage < BaseMessage

  def keys
    %i[users].freeze
  end

  def initialize(users)
    users = { users: users } if users.is_a?(Array)
    super(users)
  end

end


