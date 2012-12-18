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
    @working_time.from = @working_time.from.change(
      :day => date.day,
      :month => date.month,
      :year => date.year
    )
    
    @working_time.to = @working_time.to.change(
      :day => date.day,
      :month => date.month,
      :year => date.year
    )
    
  	respond_to do |format|
  		if @working_time.save
        flash[:notice] = "Horário cadastrado com sucesso"
  			format.js {@working_times = @professional.working_times.order("day, 'from', 'to'")}
  			format.html{redirect_to current_professional}
  			format.json
  		else
  			flash[:alert] = "Houve um erro ao criar o horário"
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