class Admin::ProfessionalsController < Admin::ApplicationController
	before_filter :authenticate_professional!

  def index
    @professionals = current_professional.salon.professionals
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @professionals }  

    end
  end

	def show
		@professional = Professional.find(params[:id])
	end

  def new
    @professional = Professional.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @professional }
    end
  end

  def create
    
    @professional = Professional.new(params[:professional])
    @professional.salon = current_professional.salon

    respond_to do |format|
      if @professional.save
        format.js
        format.html { redirect_to admin_professional_path(@professional), notice: 'Profissional criado com sucesso.' }
        format.xml  { render :xml => @professional, :status => :created, :location => @professional }
      else      
        format.js {render "create_error"}
        format.html { render :action => "new" }
        format.xml  { render :xml => @professional.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @professional = Professional.find(params[:id])
  end

  def update
    @professional = Professional.find(params[:id])
    @professional.salon = current_professional.salon
    
    respond_to do |format|
      if @professional.update_attributes(params[:professional])
        format.html { redirect_to admin_professional_url, notice: 'Profissional atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /professionals/1
  # DELETE /professionals/1.json
  def destroy
    @professional = Professional.find(params[:id])
    @professional.destroy

    respond_to do |format|
      format.html { redirect_to admin_professionals_url }
      format.js
      format.json { head :no_content }
    end
  end
end
