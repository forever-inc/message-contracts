# frozen_string_literal: true

# top level documentation
class BoxMessage < BaseMessage
  def keys
    %i[id name email phone work_order_id tracking_url text_message].freeze
  end
end
