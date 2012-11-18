class Admin::ClientsController < Admin::ApplicationController
	before_filter :authenticate_professional!
    load_and_authorize_resource

  def index
      @clients = current_professional.salon.clients

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @clients }
      end
  end

  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  def new
    @client = Client.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

	def create
		@client = Client.new(params[:client])
		generated_password = Devise.friendly_token.first(6)
		@client.password = generated_password
		@client.salons << current_professional.salon
        @client.created_by = current_professional.salon.id
    	respond_to do |format|
    	  if @client.save
            flash[:notice] = "Cliente cadastrado com sucesso!"
    	    format.html { redirect_to @client }
    	    format.json { render json: @client, status: :created, location: @client }
    	    format.js
    	  else
    	  	format.js {render "create_error"}
    	    format.html { render action: "new" }
    	    format.json { render json: @client.errors, status: :unprocessable_entity }
    	  end
    	end
	end

  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
          flash[:notice] = "Cliente atualizado com sucesso!"
        format.html { redirect_to admin_client_url }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    clientSalon = ClientSalon.where(:client_id => params[:id], :salon_id => current_professional.salon.id)
    clientSalon.destroy
 
    respond_to do |format|
      format.html { redirect_to admin_clients_url }
      format.json { head :no_content }
    end
  end
end
