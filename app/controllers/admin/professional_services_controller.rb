#encoding: utf-8

class Admin::ProfessionalServicesController < Admin::ApplicationController
	before_filter :authenticate_professional!

  def new
    @professional = Professional.find(params[:professional_id])
    @services = Service.where("id NOT IN (?)", @professional.service_ids)    
    respond_to do |format|
      format.js
    end
  end
	
  def destroy
    @professional_service = ProfessionalService.find(params[:id])
    @professional_service.destroy    
    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.js
      format.xml  { head :ok }
    end
  end

  def create
    service = Service.find(params[:service])
    professional = Professional.find(params[:professional_id])    
    @professional_service = ProfessionalService.new(:service => service, :professional => professional)

    respond_to do |format|
      if @professional_service.save
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
