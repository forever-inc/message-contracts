# frozen_string_literal: true

class UserChangedMessage
  attr_accessor :id, :email, :name

  def initialize(id:, email:, name:)
    @id = id
    @email = email
    @name = name
  end
end
