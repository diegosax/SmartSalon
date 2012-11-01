#encoding: utf-8

module EventsHelper      
      
      def add_to_valid_times(time)            
            @working_times.each do |wt|
                  if time.hour >= wt.from.hour &&
                        time.hour < wt.to.hour
                        @valid_times << time
                        return
                  end
            end            
      end

      def isavailable_mod(events, myDate, params = {})            
            puts events.inspect
            start_hour = 0
            start_min = 0      
            professional = params[:professionals]
            @working_times = professional.working_times.where(:day => myDate.wday)
            @valid_times = []
            if 
                  (
                  session[:new_start_date] &&
                  session[:new_start_date].day == myDate.day &&
                  session[:new_start_date].month == myDate.month &&
                  session[:new_start_date].year == myDate.year
                  )
                        start_hour = session[:new_start_date].hour
                        start_min = session[:new_start_date].min
                        session[:new_start_date] = nil
            end
            service = params[:service]            
            client = params[:client]
            end_time = 23
            end_min = 59
            intervalInMinutes = service.duration
            actual_date = Time.zone.local(myDate.year,myDate.month,myDate.day, start_hour, start_min)            
            end_date = Time.zone.local(myDate.year,myDate.month,myDate.day, end_time, end_min)            
            if actual_date.to_date == Date.today
                  actual_date += (DateTime.now.hour).hours
                  actual_date += service.duration.minutes
            end            
            i = 0;            
            while i < events.length && actual_date <= (end_date - intervalInMinutes.minutes) do
                  diference = (events[i].start_at.minus_with_coercion(actual_date)/60).to_i
                  if diference >= intervalInMinutes
                        add_to_valid_times(actual_date)
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
                  add_to_valid_times(actual_date)
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
            @valid_times.each do |time|
                  html << "<li>"
                  link_params = {                                    
                                    :start_at => time,
                                    :end_at => intervalInMinutes.minutes.since(time),
                                    :professionals => professional,
                                    :service => service,
                                    :client => client
                              }
                  html << link_to(
                              time.strftime("%H:%M"),link_params,
                              {
                                    "data-message" => "Deseja realmente marcar um(a) <b>#{service.name}</b> com <b>#{professional.name}</b> para #{time.strftime('%A, dia %d de %B às %H:%M')}?",
                                    :class => "new-event-link confirmable"
                              } 
                        )
                  html << "</li>"
            end
            html << "</ul>"
            html
      end
end
