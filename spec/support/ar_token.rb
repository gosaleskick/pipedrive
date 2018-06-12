# frozen_string_literal: true

class TokenAR < Struct.new(:access_token, :refresh_token, :expires_at, :company_domain)
  def update(access_token:, refresh_token:, expires_at:, company_domain:)
    self.access_token = access_token
    self.refresh_token = refresh_token
    self.expires_at = expires_at
    self.company_domain = company_domain

    true
  end
end
