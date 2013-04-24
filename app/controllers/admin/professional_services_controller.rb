#encoding: utf-8

class Admin::ProfessionalServicesController < Admin::ApplicationController
	before_filter :authenticate_professional!
  load_and_authorize_resource

  def new
    @professional = @salon.professionals.find(params[:professional_id])

    #if @professional.id != current_professional.id
    #  raise CanCan::AccessDenied.new("Not authorized!", :create, ProfessionalService)
    #end
    service_ids = @professional.service_ids
    service_ids = [-1] if service_ids.empty?
    @services = @salon.services.where("id NOT IN (?)", service_ids)    
    respond_to do |format|
      format.js
    end
  end
	
  def destroy    
    confirm_delete = params[:confirm_delete]
    @professional_service = ProfessionalService.find(params[:id])

    
    ps_events = @professional_service.professional.events.where(:service_id => @professional_service.service)

    if ps_events.length > 0 && !confirm_delete
      @professional_service.errors[:base] << "Existem agendamentos para este serviço associados ao profissional selecionado. " + 
        "A desassociação do serviço vai provocar o cancelamento desses eventos." + 
        "Você deseja confirmar a operação?"

      respond_to do |format|
        flash[:alert] = "Houve um erro ao remover o serviço deste funcionário."
        format.js { render "destroy_error"}
        format.html { redirect_to(events_url) }
        format.xml  { render :xml => @professional_service.errors, :status => :unprocessable_entity }
      end
    else
      @professional_service.destroy
      
      ps_events.each do |e|
        e.update_attributes(:reschedule => true)
      end

      respond_to do |format|
        flash[:notice] = "Desassociação efetuada com sucesso."
        format.html { redirect_to(events_url) }
        format.js
        format.xml  { head :ok }
      end
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
        format.js {render :js => "window.location.reload()"}
      end
    end    
  end
end
