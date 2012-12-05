module SalonsHelper
	def is_favorite(salon)
		if current_user && current_user.favorites.where(:salon_id => salon.id).length > 0
			"favorite"
		else
			""
		end
	end	

	def favorite? salon
		current_user && current_user.favorites.where(:salon_id => salon.id).length > 0
	end
end
