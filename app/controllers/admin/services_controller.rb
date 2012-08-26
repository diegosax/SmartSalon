class Admin::ServicesController < Admin::ApplicationController
  before_filter :authenticate_professional!

	#TODO ADICIONAR VALIDACOES PARA CHECAR SE O USUARIO LOGADO TEM PERMISSAO PARA REALIZAR A OPERAÇÃO

  def index

    @services = Service.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @services }    

    end
  end

  # GET /services/1
  # GET /services/1.json
  def show
    @service = Service.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @service }
    end
  end


  # GET /services/1/edit
  def edit
    @service = Service.find(params[:id])
  end

  # PUT /services/1
  # PUT /services/1.json
  def update
    @service = Service.find(params[:id])

    respond_to do |format|
      if @service.update_attributes(params[:service])
        format.html { redirect_to admin_service_url, notice: 'Service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service = Service.find(params[:id])
    @service.destroy

    respond_to do |format|
      format.html { redirect_to admin_services_url }
      format.json { head :no_content }
    end
  end
end
