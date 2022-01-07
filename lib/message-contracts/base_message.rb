# frozen_string_literal: true

# top level documentation
class BaseMessage < OpenStruct
  def initialize(attributes)
    super(attributes.slice(*keys))
  end

  def as_json(options = nil)
    super(options)["table"]
  end
end
