class User < ApplicationRecord
  validates :email_address, presence: true,
    uniqueness: { case_sensitive: false }
  encrypts :refresh_token
  encrypts :access_token

  has_many :slides, dependent: :destroy

  def token_refreshed
    strategy = OmniAuth::Strategies::GoogleOauth2.new("web", client_id: Yt.configuration.client_id, client_secret: Yt.configuration.client_secret)
    token = OAuth2::AccessToken.from_hash(strategy.client, access_token: access_token, refresh_token: refresh_token)
    new_token = token.refresh!
    update access_token: new_token.token, refresh_token: new_token.refresh_token
  end
end
