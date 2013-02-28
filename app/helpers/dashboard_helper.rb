#encoding: utf-8

module DashboardHelper


	def day_view_events		
		i = 0
		max = @my_today_events.length
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
				event = @my_today_events[i]
				event_html = content_tag(:p, content_tag(:strong, "Cliente: ") + event.client.name)
				event_html += content_tag(:p, content_tag(:strong, "Funcionário: ") + event.professional.name)
				event_html += content_tag(:p, content_tag(:strong, "Serviço: ") + event.service.name)
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
							:toggle => "popover",
							:content => event_html,
							:html => true,
							:trigger => "hover",
							:placement => "right",
							:container => "body"
						}
					)
					current_time += interval.minutes
					while current_time < event.end_at
						return_html += content_tag(
							:li, 
							"",
							:class => "busy empty_busy",
							:data => {
								:toggle => "popover",
								:content => event_html,
								:html => true,
								:trigger => "hover",
								:placement => "right",
								:container => "body"
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
