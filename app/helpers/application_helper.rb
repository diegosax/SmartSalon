module ApplicationHelper
	def isClient?
		return current_user.class == Client
	end

	def isProfessional?
		return current_user.class == Lawyer
	end
end
