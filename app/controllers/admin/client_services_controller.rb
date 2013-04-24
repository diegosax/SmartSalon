#encoding: utf-8

class Admin::ClientServicesController < Admin::ApplicationController
  before_filter :authenticate_professional!

  def index
  end

  def new    
  	if params[:service_id]
  		@service = @salon.services.find(params[:service_id])
  		@clientService = @salon.client_services.build(:service => @service)      
  	elsif params[:client_id]
  		@client = @salon.clients.find(params[:client_id])
  		@clientService = @salon.client_services.build(:client => @client)
  	end  	  	
  end

  def create
    service = @salon.services.find(params[:service_id]) if params[:service_id] != ""
    client = @salon.clients.find(params[:client_id]) if params[:client_id] != ""

    @client_service = @salon.client_services.new(:service => service, :client => client, :duration => params[:duration])    
    respond_to do |format|
      if @client_service.save
        flash[:notice] = "Associação efetuada com sucesso"
        format.html {redirect_to :back}
        format.js
      else
        flash[:alert] = "Houve um erro ao definir o tempo de serviço para esse cliente."
        format.html {redirect_to :back}
        format.js {render 'create_error'}
      end
    end    
  end

  def destroy    
    @client_service = @salon.client_services.find(params[:id])
    @client_service.destroy
    respond_to do |format|     
      flash[:notice] = "Associação removida com sucesso!"
      format.html {redirect_to :back}
      format.js #{render :js => "window.location.reload()"}
      format.json
    end       
  end
end
