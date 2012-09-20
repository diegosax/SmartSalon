#encoding: utf-8

module EventsHelper	
      def isavailable_mod(events, myDate, professionals = nil, service)      
            start_hour = 8
            start_min = 0
            if 
                  (
                  session[:new_start_date] &&
                  session[:new_start_date].day == myDate.day &&
                  session[:new_start_date].month == myDate.month &&
                  session[:new_start_date].year == myDate.year
                  )

                        puts "Servico: " + service.inspect.to_s
                        start_hour = session[:new_start_date].hour
                        start_min = session[:new_start_date].min
                        session[:new_start_date] = nil
            end
            
            end_time = 18
            intervalInMinutes = service.duration
            actual_date = Time.zone.local(myDate.year,myDate.month,myDate.day, start_hour, start_min)            
            end_date = Time.zone.local(myDate.year,myDate.month,myDate.day, end_time, 0)            
            if actual_date.to_date == Date.today
                  actual_date += (DateTime.now.hour - start_hour).hours + service.duration.minutes
            end

            valid_times = []
            i = 0;
            while i < events.length && actual_date <= (end_date - intervalInMinutes.minutes) do
                  diference = (events[i].start_at.minus_with_coercion(actual_date)/60).to_i
                  if diference >= intervalInMinutes
                        valid_times << actual_date
                        if diference < (intervalInMinutes * 2)
                              actual_date = events[i].end_at
                              i+=1
                        else
                              actual_date += intervalInMinutes.minutes
                        end
                  else
                        if (events[i].end_at.minus_with_coercion(actual_date)/60).to_i > 0
                              actual_date = events[i].end_at      
                        else
                              actual_date += intervalInMinutes.minutes
                        end                        
                        i+=1
                  end
            end

            while actual_date <= (end_date - intervalInMinutes.minutes) do
                  valid_times << actual_date
                  actual_date += intervalInMinutes.minutes
            end

            if    
                  (
                        actual_date.day != end_date.day ||
                        actual_date.month != end_date.month ||
                        actual_date.year != end_date.year
                  )
                  session[:new_start_date] = actual_date;
            end

            html = "<ul>"
            valid_times.each do |time|
                  html << "<li>"
                  link_params = {                                    
                                    :start_at => time,
                                    :end_at => intervalInMinutes.minutes.since(time),
                                    :professionals => professionals,
                                    :service => service
                              }
                  html << link_to(
                              time.strftime("%H:%M"),link_params,
                              {
                                    "data-message" => "Deseja realmente marcar um(a) <b>#{service.name}</b> com <b>#{professionals.name}</b> para #{time.strftime('%A, dia %d de %B às %H:%M')}?",
                                    :class => "new-event-link confirmable"
                              } 
                        )
                  html << "</li>"
            end
            html << "</ul>"
            html
      end
end
