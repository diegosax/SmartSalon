module ApplicationHelper
	def isClient?
		return current_user.class == Client
	end

	def isProfessional?
		return current_user.class == Lawyer
	end

	def active_class(controller)
		controller == controller_name ? "active" : ""
	end

	def active_action(controller, action)
		if controller == controller_name
			action == action_name ? "active" : ""
		end
	end
end
