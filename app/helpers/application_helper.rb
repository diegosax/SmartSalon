module ApplicationHelper
	def isClient?
		return current_user.class == Client
	end

	def isProfessional?
		return current_user.class == Lawyer
	end

	def active_class(controller)
		puts controller
		puts controller_name
		puts controller_name == controller
		controller == controller_name ? "active" : ""
	end
end
