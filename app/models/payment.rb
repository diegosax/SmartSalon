class Payment < ActiveRecord::Base
  attr_accessible :description, :due_date, :payment_date, :status
  belongs_to :subscription
  validates :description, :due_date, :payment_date, :status, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
end
