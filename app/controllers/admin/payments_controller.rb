class Admin::PaymentsController < Admin::ApplicationController
	before_filter :authenticate_professional!

	def checkout
		if params[:payment_type] == "boleto"
			salon = current_professional.salon
			payment = salon.subscriptions.last.payments.payable.order(:due_date).first			
			payer = salon.to_moip_payer_format
			invoice = {
				:razao => "Pagamento Mensalidade do mes de #{payment.due_date.strftime('%B')}",
				:id_proprio => "#{salon.id}-#{payment.subscription.id}-#{payment.id}-#{Time.now.to_i}",
				:valor => payment.price,
				:forma => "BoletoBancario",
				:dias_expiracao => "5",
				:pagador => payer
			}
			
			response = Moip::MoipClient.checkout(invoice)
  			# exibe o boleto para impressão
  			puts "DADOS DE RETORNO: #{response}"
  			redirect_to Moip::MoipClient.moip_page(response["Token"])
		end
	end
end
