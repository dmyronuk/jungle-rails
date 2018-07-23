class User < ActiveRecord::Base
  has_many :reviews

  has_secure_password
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
end
