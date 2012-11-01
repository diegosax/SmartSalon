class Payment < ActiveRecord::Base
  attr_accessible :description, :due_date, :payment_date, :status, :price
  belongs_to :subscription
  validates :description, :due_date, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  scope :payable, where("status = 'A Pagar' OR status = 'Cancelado' OR status = 'Vencido'")
end
