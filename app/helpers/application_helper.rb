#encoding: utf-8

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

	def event_type(event)
		if event.status == "Agendado"
			"success"
		elsif event.status == "Cancelado"
			"important"
		else
			""
		end
	end

	def payment_status_type(status)
		if status == Payment::STATUS[5] || status == Payment::STATUS[99]
			"important"
		elsif status == Payment::STATUS[1] || status == Payment::STATUS[4]
			"success"
		else
			"warning"
		end
	end
end
