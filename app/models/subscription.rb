class Subscription < ActiveRecord::Base  
  has_many  :payments
  belongs_to :salon
  validates :end_date, :initial_date, :price, :status, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
end
