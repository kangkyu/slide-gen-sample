class User < ApplicationRecord
  validates :email_address, presence: true,
    uniqueness: { case_sensitive: false }
  encrypts :refresh_token
  encrypts :access_token

  has_many :slides, dependent: :destroy
end
