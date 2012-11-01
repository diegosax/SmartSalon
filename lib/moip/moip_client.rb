# encoding: utf-8

module Moip
  class WebServerResponseError < StandardError ; end
  class MissingConfigError < StandardError ; end
  class MissingTokenError < StandardError ; end
  class MissingKeyError < StandardError ; end

  class MoipClient
    include HTTParty

    base_uri "#{Moip.uri}/ws/alpha"
    basic_auth Moip.token, Moip.key

    class << self
      
      def verify account
        full_data = peform_action!(:get, "VerificarConta/#{account}")        
        return full_data["verificarContaResponse"]["RespostaVerificarConta"]["Status"] == "Verificado"
      end

      # Envia uma instrução para pagamento único
      def checkout(attributes = {})
        body = DirectPayment.body(attributes)
        puts "************ XML ************"
        puts body
        full_data = peform_action!(:post, 'EnviarInstrucao/Unica', :body => body)
        puts full_data
       # raise full_data.inspect
       get_response!(full_data["EnviarInstrucaoUnicaResponse"]["Resposta"])
     end

      # Consulta dos dados das autorizações e pagamentos associados à Instrução
      def query(token)
        full_data = peform_action!(:get, "ConsultarInstrucao/#{token}")

        get_response!(full_data["ConsultarTokenResponse"]["RespostaConsultar"])
      end

      # Retorna a URL de acesso ao Moip
      def moip_page(token)
        raise(MissingTokenError, "É necessário informar um token para retornar os dados da transação") if token.nil?
        "#{Moip.uri}/Instrucao.do?token=#{token}"
      end

      # Monta o NASP
      def notification(params)
        notification = {}
        notification[:transaction_id] = params["id_transacao"]
        notification[:amount]         = params["valor"]
        notification[:status]         = Moip::STATUS[params["status_pagamento"].to_i]
        notification[:code]           = params["cod_moip"]
        notification[:payment_type]   = params["tipo_pagamento"]
        notification[:email]          = params["email_consumidor"]
        notification
      end

      private

      def peform_action!(action_name, url, options = {})

        puts "MOIP account: #{Moip.key}"
        raise(MissingConfigError, "É necessário criar um arquivo de configuração para o moip. Veja mais em: https://github.com/moiplabs/moip-ruby") if Moip.token.nil? && Moip.key.nil?

        raise(MissingTokenError, "É necessário informar um token na configuração") if Moip.token.nil? || Moip.token.empty?

        raise(MissingKeyError, "É necessário informar um key na configuração") if Moip.key.nil? || Moip.key.empty?
        
        response = self.send(action_name, url, options)
        raise(WebServerResponseError, "Ocorreu um erro ao chamar o webservice") if response.nil?        
        response
      end

      def get_response!(data)
        # raise data.inspect
        err = data["Erro"].is_a?(Array) ? data["Erro"].join(", ") : data["Erro"]
        raise(WebServerResponseError, err) if data["Status"] == "Falha"
        data
      end
    end
  end
end