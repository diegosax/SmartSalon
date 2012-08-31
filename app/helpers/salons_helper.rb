module SalonsHelper
	def is_favorite(salon)
		if current_user && current_user.favorites.where(:salon_id => salon.id).length > 0
			puts "salao #{salon.id} eh favorito"
			"favorite"
		else
			""
		end
	end
end
