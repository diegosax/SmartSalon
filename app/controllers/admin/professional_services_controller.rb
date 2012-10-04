class Admin::ProfessionalServicesController < Admin::ApplicationController
	before_filter :authenticate_professional!
	
    def destroy
        @professional_service = current_professional.professional_services.find(params[:id])
        @professional_service.destroy
        respond_to do |format|
          format.html { redirect_to(events_url) }
          format.js
          format.xml  { head :ok }
      end
  end

end