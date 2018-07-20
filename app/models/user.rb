class User < ActiveRecord::Base
  has_many :reviews

  has_secure_password
  validates :first_name, :last_name, :email, presence: true
end
