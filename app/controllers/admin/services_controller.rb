class Admin::ServicesController < Admin::ApplicationController
  before_filter :authenticate_professional!

  def index

    @services = Service.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @services }    

    end
  end
end
