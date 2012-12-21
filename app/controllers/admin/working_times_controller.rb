#encoding: utf-8

class Admin::WorkingTimesController < Admin::ApplicationController  
  before_filter :authenticate_professional!
  load_and_authorize_resource 

  def new
  end

  def create    
    @professional = Professional.find(params[:professional_id])
  	@working_time = @professional.working_times.new(params[:working_time])    
    date = Time.zone.parse("2000-01-01")
    if @working_time.valid?
      @working_time.from_time = @working_time.from_time.change(
        :day => date.day,
        :month => date.month,
        :year => date.year
      )
      
      @working_time.to_time = @working_time.to_time.change(
        :day => date.day,
        :month => date.month,
        :year => date.year
      )
    end
    
  	respond_to do |format|
  		if @working_time.save
        flash[:notice] = "Horário cadastrado com sucesso"
  			format.js {@working_times = @professional.working_times.order("day, 'from_time', 'to_time'")}
  			format.html{redirect_to current_professional}
  			format.json
  		else
        if @working_time.errors.empty?
  		    flash[:alert] = "Erro ao criar horário"
        else
          flash[:alert] = @working_time.errors.full_messages.first
        end
  			format.js {render "create_error"}
  			format.html{redirect_to current_professional}
  			format.json
  		end
  	end
  end

  def edit
  end

  def update
  end

  def destroy
    @working_time = WorkingTime.find(params[:id])  
    @working_time.destroy
    respond_to do |format|
      flash[:notice] = "Horário removido com sucesso!"
      format.html { redirect_to(@working_time.professional) }
      format.js
      format.xml  { head :ok }
    end
  end

end