class Admin::SalonsController < Admin::ApplicationController
  before_filter :authenticate_professional!

  # GET /services/1
  # GET /services/1.json
  def show
    @salon = Salon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @service }
    end
  end

end
