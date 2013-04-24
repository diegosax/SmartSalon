class Admin::SalonsController < Admin::ApplicationController
  before_filter :authenticate_professional!
  load_and_authorize_resource

  # GET /services/1
  # GET /services/1.json
  def show
    @salon = Salon.find(params[:id])
    #@currentSubscription = @salon.subscriptions.last
    #@payments = @currentSubscription.payments.order(:due_date)
    @uploader = Salon.new.logo
    @uploader.success_action_redirect = salons_url(@salon)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @service }
    end
  end

  # GET /Salons/1/edit
  def edit
    @salon = current_professional.salon    
  end

  # PUT /salons/1
  # PUT /salons/1.json
  def update
    @salon = Salon.find(params[:id])

    respond_to do |format|
      if @salon.update_attributes(params[:salon])
        format.html { redirect_to [:admin,@salon], notice: 'Salao atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @salon.errors, status: :unprocessable_entity }
      end
    end
  end
  
  #busca de cep - endereco
  def search_zipcode
    begin
      @address = BuscaEndereco.cep(params[:zipcode])      
    rescue
      @address = nil      
    end
    respond_to do |format|
      format.js
    end
  end
end
