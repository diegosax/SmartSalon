class FavoritesController < ApplicationController
  def create
  	salon = Salon.find(params[:salon_id])  	  	
    @favorite = current_user.favorites.create(:salon => salon)
    respond_to do |format|
      if @favorite.save
      	format.js
      	format.html
      else
        format.js {render "create_error"}
        
      end
    end
  end

  def destroy
    salon = Salon.find(params[:id])     
    begin  
      @favorite = current_user.favorites.where(:salon_id => salon).first    
      if @favorite
        @favorite.destroy
      else
        @salon = current_user.salons.find(salon)
        current_user.salons.delete(@salon)
      end
      respond_to do |format|      
        format.js
        format.html      
      end
    rescue
      respond_to do |format|      
        format.js {render "destroy_error"}
        format.html      
      end
    end
  end
end
