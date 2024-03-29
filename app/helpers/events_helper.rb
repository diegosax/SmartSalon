#encoding: utf-8

module EventsHelper      
      
      def add_to_valid_times(time)            
            @working_times.each do |wt|
                  if time.hour >= wt.from_time.hour &&
                        time.hour < wt.to_time.hour
                        @valid_times << time
                        return
                  end
            end            
      end

      def format_date_header(date)
            if date == Time.zone.today
                  "Hoje"
            elsif date == Time.zone.today.tomorrow
                  "Amanhã"
            else
                  date.strftime("%d de %B")
            end
      end

      def isavailable_mod(events, myDate, params = {})                        
            start_hour = 0
            start_min = 0      
            professional = params[:professionals]
            service = params[:service]         
            client = params[:client]
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
            end_time = 23
            end_min = 59
            intervalInMinutes = service.preferred_duration(client)
            actual_date = Time.zone.local(myDate.year,myDate.month,myDate.day, start_hour, start_min)            
            end_date = Time.zone.local(myDate.year,myDate.month,myDate.day, end_time, end_min)            
            if actual_date.to_date == Time.zone.today
                  actual_date += (DateTime.now.hour).hours
                  actual_date += service.duration.minutes
            end                       
            i = 0;            
            puts actual_date
            while i < events.length && actual_date <= (end_date - intervalInMinutes.minutes) do
                  puts events[i].start_at
                  puts actual_date
                  diference = (events[i].start_at - actual_date)/60
                  puts diference
                  puts "Entrou no while"
                  if diference >= intervalInMinutes
                        add_to_valid_times(actual_date)
                        puts "Adicionou o #{actual_date} aos horarios válidos"
                        if diference < (intervalInMinutes * 2)
                              actual_date = events[i].end_at
                              i+=1
                        else
                              actual_date += intervalInMinutes.minutes
                        end
                  else
                        puts "Caiu no else ao inves de adicionar aos validos"
                        puts "#{diference} | #{intervalInMinutes}"
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
                  #puts "Adicionou p #{actual_date} aos horarios validos pq nao existem mais eventos"
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
                              :professionals => professional,
                              :service => service,
                              :client => client,
                              :start_at => time,
                              :end_at => intervalInMinutes.minutes.since(time)                                    
                  }
                  html << link_to(
                              time.strftime("%H:%M"), link_params,
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
