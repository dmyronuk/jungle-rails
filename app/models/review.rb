class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :rating, :product_id, :user_id, presence: true
end
