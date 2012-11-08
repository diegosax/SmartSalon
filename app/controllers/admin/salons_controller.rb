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

end
