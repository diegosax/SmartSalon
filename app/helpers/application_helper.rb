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

	def formatted_phone(phone)
		phone.sub(/(\d{2})(\d{4})(\d{4})/, "(\\1) \\2-\\3") if phone
	end

	def day_view_events(events = @my_today_events)				
		i = 0
		max = events.length
		puts max
		current_time = Time.zone.parse("00:00")
		end_time = Time.zone.parse("24:00")
		interval = 15
		return_html = ""
		while current_time < end_time
			#No more events to load
			if i==max
				while current_time < end_time
					return_html+= content_tag :li
					current_time += interval.minutes
				end
			else
				event = events[i]
				event_html = content_tag(:p, content_tag(:strong, "Cliente: ") + event.client.name) if event.client
				event_html += content_tag(:p, content_tag(:strong, "Funcionário: ") + event.professional.name) if event.professional
				event_html += content_tag(:p, content_tag(:strong, "Serviço: ") + event.service.name) if event.service
				event_html += content_tag(:p, content_tag(:strong, "Início: ") + event.start_at.strftime("%H:%M"))
				event_html += content_tag(:p, content_tag(:strong, "Fim: ") + event.end_at.strftime("%H:%M"))
				while current_time < event.start_at
					return_html += content_tag :li
					current_time += interval.minutes
				end
				if current_time >= event.start_at && current_time <= event.start_at + interval.minutes
					return_html += content_tag(
						:li, 
						event.client.name, 
						:class => "busy",
						:data =>{
							:event_id => event.id
						}
					)
					current_time += interval.minutes
					while current_time < event.end_at
						return_html += content_tag(
							:li, 
							"",
							:class => "busy empty_busy",
							:data => {
								:event_id => event.id
							}
						)
						current_time += interval.minutes
					end
				end
				i+=1	
			end			
		end
		return_html
	end
end
