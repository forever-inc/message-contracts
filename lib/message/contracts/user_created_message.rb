# frozen_string_literal: true

class UserCreatedMessage
  attr_accessor :id, :email, :name

  def initialize(id:, email:, name:)
    @id = id
    @email = email
    @name = name
  end
end
