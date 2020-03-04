class User < ApplicationRecord

has_secure_password
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true

  def self.make_omni_player(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.password = SecureRandom.hex
    end
  end
    
end