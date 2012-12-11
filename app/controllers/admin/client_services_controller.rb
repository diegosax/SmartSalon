#encoding: utf-8

class Admin::ClientServicesController < Admin::ApplicationController
  before_filter :authenticate_professional!

  def index
  end

  def new
  	if params[:service_id]
  		@service = @salon.services.find(params[:service_id])
  		@clientService = @service.client_services.build
  	elsif params[:client_id]
  		@client = @salon.clients.find(params[:client_id])
  		@clientService = @client.client_services.build
  	end  	  	
  end

  def create
    service = @salon.services.find(params[:service_id])
    client = @salon.clients.find(params[:client_id])

    @client_service = ClientService.new(:service => service, :client => client, :duration => params[:duration])

    respond_to do |format|
      if @client_service.save
        flash[:notice] = "Associação efetuada com sucesso"
        format.html
        format.js
      else
        flash[:alert] = "Houve um erro na associação"
        format.html
        format.js {render 'create_error'}
      end
    end    
  end
end
