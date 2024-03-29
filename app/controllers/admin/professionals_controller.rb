#encoding : utf-8
class Admin::ProfessionalsController < Admin::ApplicationController
	before_filter :authenticate_professional!
  load_and_authorize_resource
  skip_authorize_resource :only => :search_zipcode

  def index
    @professionals = current_professional.salon.professionals
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @professionals }
    end
  end  

  def show
    @professional = Professional.find(params[:id])
    @working_times = @professional.working_times.order("day")
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
    @working_times = @professional.working_times.order("day, 'from', 'to'")
  end

  def update
    @professional = Professional.find(params[:id])
    if params[:professional][:password].blank? && params[:professional][:password_confirmation].blank?
      params[:professional].delete(:password)
      params[:professional].delete(:password_confirmation)
    end
    respond_to do |format|
      if @professional.update_attributes(params[:professional])
        format.html { redirect_to admin_professional_url, notice: 'Profissional atualizado com sucesso.' }
        format.json { head :no_content }
      else
        puts @professional.errors.inspect
        format.html { render action: "edit" }
        format.json { render json: @professional.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /professionals/1
  # DELETE /professionals/1.json
  def destroy

    confirm_delete = params[:confirm_delete]
    @professional = Professional.find(params[:id])

    if @professional.events.length > 0 && !confirm_delete
      @professional.errors[:base] << "Existem agendamentos para este professional. " + 
      "A exclusão do professional vai provocar o cancelamento desses eventos." + 
      "Você deseja confirmar a operação?"

      respond_to do |format|
        format.js { render "destroy_error"}
        format.html { redirect_to admin_professionals_url }
        format.xml  { render :xml => @professional.errors, :status => :unprocessable_entity }
      end
    else

      @professional.destroy

      @professional.events.each do |e|
        e.update_attributes(:reschedule => true)
      end

      respond_to do |format|
        format.html { redirect_to admin_professionals_url }
        format.json { head :no_content }
        format.js
      end      
    end
  end

  def search_zipcode
    begin
      @address = BuscaEndereco.cep(params[:zipcode])      
    rescue
      @address = nil      
    end
    respond_to do |format|
      format.js
    end
  end

  def update_password
    @professional = current_professional
    if @professional.update_attributes(params[:professional])      
      redirect_to [:admin, @professional], :notice => "Senha alterada com sucesso"
    else
      redirect_to [:admin, @professional], :notice => "Houve um erro ao tentar alterar sua senha"
    end
  end

end
