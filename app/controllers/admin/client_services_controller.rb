#encoding: utf-8

class Admin::ClientServicesController < Admin::ApplicationController
  before_filter :authenticate_professional!

  def index
  end

  def new
    sleep 1
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
        format.html {redirect_to :back}
        format.js
      else
        flash[:alert] = "Erro: #{@client_service.client.name} já está com um tempo personalizado definido para #{@client_service.service.name}"
        format.html {redirect_to :back}
        format.js {render 'create_error'}
      end
    end    
  end

  def destroy
    puts "Caiu no metodo certo!!!"
    @client_service = ClientService.find(params[:id])
    @client_service.destroy
    respond_to do |format|     
      flash[:notice] = "Associação removida com sucesso!"
      format.html {redirect_to :back}
      format.js {render :js => "window.location.reload()"}
      format.json
    end       
  end
end
