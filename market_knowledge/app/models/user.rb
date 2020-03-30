class User < ApplicationRecord

has_secure_password
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /(?:(?:[\w`~!#$%^&*\-=+;:{}'|,?\/]+(?:(?:\.(?:"(?:\\?[\w`~!#$%^&*\-=+;:{}'|,?\/\.()<>\[\] @]|\\"|\\\\)*"|[\w`~!#$%^&*\-=+;:{}'|,?\/]+))*\.[\w`~!#$%^&*\-=+;:{}'|,?\/]+)?)|(?:"(?:\\?[\w`~!#$%^&*\-=+;:{}'|,?\/\.()<>\[\] @]|\\"|\\\\)+"))@(?:sunvest-re.com)/ }
  validates :password, presence: true

  def self.make_omni_player(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.password = SecureRandom.hex
    end
  end
    
end