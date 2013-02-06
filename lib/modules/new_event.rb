module NewEvent
  def find_new_event
    if current_professional || params[:salon_id].present?      
      @salon = current_professional ? current_professional.salon : Salon.find(params[:salon_id])      
      @client = Client.find(params[:client]) unless params[:client].blank?
      @services = @salon.services
      if params[:service] || @service        
        @service ||= @salon.services.find(params[:service])
        if params[:professionals]
          if params[:professionals] == "any"
            @service_professionals = @service.professionals
          else
            @service_professionals = @service.professionals.find(params[:professionals])
          end                      
        end
        @professionals = @service.professionals
      end
    else      
      @my_salons_and_favorites = current_user.my_salons_and_favorites if current_user
    end    
    if @service_professionals && @salon
      @events = Event.active.where(        
        "(start_at >= ? OR end_at >= ?) AND professional_id in (?)", 
          Time.zone.now.beginning_of_day,
          Time.zone.now.end_of_day,
          @service_professionals).order("start_at")          
      @date = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    end 
  end
end