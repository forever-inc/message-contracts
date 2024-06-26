# frozen_string_literal: true

# top level documentation
class UserMessage < BaseMessage
  def keys
    %i[id name email role membership storage_capacity storage_used tos_agreed
       stripe_customer_id ambassador_id
       last_sign_in_at last_sign_in_ip failed_attempts deleted_at
       created_at updated_at avatar_url_small avatar_url p2p_membership_id
       slug email_confirmed_at verified_at purged_at abilities tsv_name source metadata reset_password_token storage_audit_id].freeze
  end
end
