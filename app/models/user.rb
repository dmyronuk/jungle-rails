class User < ActiveRecord::Base
  has_many :reviews

  has_secure_password
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  private
    def self.authenticate_with_credentials(email, password)
      email = email.downcase
      user = User.find_by_email(email.strip)
      if user && user.authenticate(password)
        return user
      else
        return nil
      end
    end
end
