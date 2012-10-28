#encoding : utf-8
class Admin::ServicesController < Admin::ApplicationController
  before_filter :authenticate_professional! 
  load_and_authorize_resource

  def index
    @services = current_professional.salon.services
    
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

  # GET /services/new
  # GET /services/new.json
  def new
    @service = Service.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @service }
    end
  end

  # GET /services/1/edit
  def edit
    @service = Service.find(params[:id])
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(params[:service])
    @service.salon = current_professional.salon

    respond_to do |format|
      if @service.save
        format.html { redirect_to admin_service_path(@service), notice: 'Service was successfully created.' }
        format.json { render json: @service, status: :created, location: @service }
      else
        format.html { render action: "new" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /services/1
  # PUT /services/1.json
  def update
    @service = Service.find(params[:id])
    @service.salon = current_professional.salon

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

    confirm_delete = params[:confirm_delete]
    @service = Service.find(params[:id])

    if @service.events.length > 0 && !confirm_delete
      @service.errors[:base] << "Existem agendamentos para este serviço. " + 
        "A exclusão do serviço vai provocar o cancelamento desses eventos." + 
        "Você deseja confirmar a operação?"

      respond_to do |format|
        format.js { render "destroy_error"}
        format.html { redirect_to admin_services_url }
        format.xml  { render :xml => @service.errors, :status => :unprocessable_entity }
      end
    else
      @service.destroy

      @service.events.each do |e|
        e.update_attributes(:reschedule => true)
        if(e.client)
          Notifier.client_event_canceled(e).deliver
        end
        if(e.professional)
          Notifier.professional_event_canceled(e).deliver
        end
      end

      respond_to do |format|
        format.html { redirect_to admin_services_url }
        format.json { head :no_content }
        format.js
      end      
    end     
  end
end
