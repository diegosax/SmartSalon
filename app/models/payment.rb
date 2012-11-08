#encoding: utf-8

class Payment < ActiveRecord::Base
  attr_accessible :description, :due_date, :payment_date, :status, :price
  belongs_to :subscription
  validates :description, :due_date, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  scope :payable, where("status = 'A Pagar' OR status = 'Cancelado' OR status = 'Vencido'")

  #TODO: Add Internationalization

  STATUS = {
  	1 => "Pagamento Autorizado", 
  	2 => "Pagamento Iniciado", 
  	3 => "Boleto Impresso", 
  	4 => "Pagamento Recebido", 
  	5 => "Pagamento Cancelado", 
  	6 => "Pagamento em Análise",
  	98 => "A Pagar",
  	99 => "Vencido"
  }

  PAYMENT_MODES = {
  	1 => "Saldo MoIP", 
  	3 => "Visa", 
  	5 => "Mastercard",
  	6 => "Diners", 
  	7 => "American Express",
  	8 => "Banco do Brasil",
  	13 => "Itaú",
  	22 => "Bradesco",
  	75 => "Hipercard",
  	76 => "Oi Paggo",
  	88 => "Banrisul",
  }

  PAYMENT_TYPES = {
  	"BoletoBancario" => "Boleto Bancário",
  	"CartaoDeCredito" => "Cartão de Crédito",
  	"CartaoDeDebito" => "Cartão de Débito",
  	"DebitoBancario" => "Débito em Conta",
  	"CarteiraMoip" => "Saldo Conta Moip"
  }

end
