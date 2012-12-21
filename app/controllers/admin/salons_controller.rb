class Admin::SalonsController < Admin::ApplicationController
  before_filter :authenticate_professional!
  load_and_authorize_resource

  # GET /services/1
  # GET /services/1.json
  def show
    @salon = Salon.find(params[:id])
    @currentSubscription = @salon.subscriptions.last
    @payments = @currentSubscription.payments.order(:due_date)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @service }
    end
  end

  # GET /Salons/1/edit
  def edit
    @salon = Salon.find(params[:id])
  end

  # PUT /salons/1
  # PUT /salons/1.json
  def update
    @salon = Salon.find(params[:id])

    respond_to do |format|
      if @salon.update_attributes(params[:salon])
        format.html { redirect_to [:admin,@salon], notice: 'Salao atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @salon.errors, status: :unprocessable_entity }
      end
    end
  end
end
