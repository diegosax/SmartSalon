#encoding: utf-8

class Admin::WorkingTimesController < Admin::ApplicationController  
  before_filter :authenticate_professional!

  def new
  end

  def create
  	@working_time = current_professional.working_times.new(params[:working_time])
  	respond_to do |format|
  		if @working_time.save
  			flash[:notice] = "Horário cadastrado com sucesso"
  			format.js
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

end