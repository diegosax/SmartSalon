#encoding: utf-8

class SalonsController < ApplicationController
  # GET /salons
  # GET /salons.json  
  def index 
    @salons = if params[:location].present?
      Salon.near(formatted(params[:location]), 30, :order => :distance).page(params[:page]).per(2)
    elsif params[:query].present?
      Salon.text_search(params[:query]).page(params[:page]).per(2)
    else
      nil
    end    
    @my_salons_and_favorites = current_user.my_salons_and_favorites if current_user
    
      respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @salons }
    end
  end

  # GET /salons/1
  # GET /salons/1.json
  def show
    @salon = Salon.find(params[:id]) 

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @salon }
    end
  end

  # GET /salons/new
  # GET /salons/new.json
  def new
    @salon = Salon.new
    @salon.build_manager
    respond_to do |format|
      format.html {render :layout => false}
      format.json { render json: @salon }
    end
  end

  # POST /salons
  # POST /salons.json
  def create
    @salon = Salon.new(params[:salon])
    @salon.manager.role = "admin"  
    respond_to do |format|
      if @salon.save
        format.html { redirect_to [:admin,@salon], notice: 'Salão criado com sucesso! Por favor, complete seu cadastro' }
        format.json { render json: @salon, status: :created, location: @salon }
      else
        format.html { render action: "new", :layout => false }
        format.json { render json: @salon.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def formatted(address)
    address.gsub(/^(.{5})(.{3})$/,'\1-\2')
  end

  def closest_timezones(zipcode)
    
  end
end
