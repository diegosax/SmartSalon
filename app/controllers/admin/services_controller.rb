class Admin::ServicesController < Admin::ApplicationController
  before_filter :authenticate_professional!

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
    @current_professional = current_professional

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @service }
    end
  end

  # GET /services/1/edit
  def edit
    @current_professional = current_professional
    @service = Service.find(params[:id])
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(params[:service])
    @service.salon = current_professional.salon
    if params[:service_professionals]
        @service.professionals = Professional.find(params[:service_professionals])
    end

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
    if params[:service_professionals]
        @service.professionals = Professional.find(params[:service_professionals])
    else
        @service.professionals = []
    end

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
