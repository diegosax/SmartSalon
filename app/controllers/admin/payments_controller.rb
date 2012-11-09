#encoding: utf-8

class Admin::PaymentsController < Admin::ApplicationController
	before_filter :authenticate_professional!, :except => [:notification]

	def checkout		
		@salon = current_professional.salon
		@payment = @salon.subscriptions.last.payments.find(params[:payment])
		@payer = @salon.to_moip_payer_format
		@invoice = {
			:razao => "Pagamento Mensalidade do mes de #{@payment.due_date.strftime('%B')}",
			:id_proprio => "#{@salon.id}-#{@payment.subscription.id}-#{@payment.id}-#{Time.now.to_i}",
			:valor => @payment.price,				
			:pagador => @payer
		}
		
		@response = Moip::MoipClient.checkout(@invoice)
		# exibe o boleto para impressão
		puts "DADOS DE RETORNO: #{response}"
		#by uncommenting the next line the buyer will be redirected to the Moip Payment Page
    #redirect_to Moip::MoipClient.moip_page(response["Token"])

    #by using this code the buyer won't leave the company page
    #Transparent checkout

    respond_to do |format|
      format.js
    end
  end

  def notification
    puts "NOTIFICATION RECEIVED:"
    puts params.inspect
    notification = Moip::MoipClient.notification(params)
    id = notification[:transaction_id]
    salon = Salon.find(extract_salon_from_moip_id(id))
    subscription = salon.subscriptions.last
    puts "SUBSCRIPTION ID: #{subscription.id}"
    puts "extracted: #{extract_subscription_from_moip_id(id)}"		
    if subscription.id.to_s == extract_subscription_from_moip_id(id).to_s
      puts "PASSOU DO PRIMEIRO, SUBSCRIPTION MATCH"
      payment = subscription.payments.find(extract_payment_from_moip_id(id))			
      if payment
        puts "PASSOU DO PAYMENT, ELE EXISTE"				
        if payment.locked && notification[:status] == 4
          puts 'ATUALIZANDO STATUS DEENTRO DO IF'
          payment.status = Payment::STATUS[notification[:status]]
        else
          payment.status = Payment::STATUS[notification[:status]]
          payment.payment_mode = Payment::PAYMENT_MODES[notification[:payment_mode]]
          payment.payment_type = Payment::PAYMENT_TYPES[notification[:payment_type]]
          payment.moip_code = notification[:moip_code]
          if notification[:status] == 1 || notification[:status] == 4
            payment.payment_date = Time.zone.now
            payment.locked = true
          end
        end              				
        payment.save
      end      
    else
      puts "Subscription not found"
    end
    render :nothing => true, :status => 200
  end

  def invoice
    @payment = Payment.find(params[:payment_id])
  end
end