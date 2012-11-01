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
		if status == "A Pagar" || status == "Iniciado" || status == "Autorizado" || status == "Boleto Impresso"
			"warning"
		elsif status == "Cancelado" || status == "Vencido"
			"important"
		elsif status == "Pagamento Confirmado"
			"success"
		end
	end
end
