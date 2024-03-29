# encoding: utf-8
require "rubygems"
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/deprecation'
require 'builder'
require 'logger'
require 'json'

module Moip

  class ValidationError < StandardError; end

  class MissingPaymentTypeError < ValidationError; end
  class MissingPayerError < ValidationError; end
  class MissingBirthdate < ValidationError; end

  class InvalidCellphone < ValidationError; end
  class InvalidExpiry < ValidationError; end
  class InvalidInstitution < ValidationError; end    
  class InvalidPhone < ValidationError; end
  class InvalidReceiving < ValidationError; end
  class InvalidValue < ValidationError; end

  autoload :DirectPayment, 'moip/direct_payment'
  autoload :Client,        'moip/client'

  # URI para acessar o serviço
  mattr_accessor :uri
  @@uri = 'https://www.moip.com.br'

  # Token de autenticação
  mattr_accessor :token

  # Chave de acesso ao serviço
  mattr_accessor :key

  def self.setup
    yield self
  end

  STATUS = {1 => "authorized", 2 => "started", 3 => "printed", 4 => "completed", 5 => "canceled", 6 => "analysing"}
end