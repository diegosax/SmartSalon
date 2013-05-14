#encoding: utf-8

class EventsDatatable
  delegate :params, :h, :link_to, :distance_of_time_in_words, :current_professional, :number_to_currency, to: :@view  

  def initialize(view,salon)
    @view = view    
    @salon = salon
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Event.count,
      iTotalDisplayRecords: events.total_count,
      aaData: data
    }
  end

private

  def data
    events.map do |event|
      [
        link_to(event.id, event),
        h(event.client.name),
        h(event.professional.name),
        h(event.service.name),
        h(event.start_at.strftime("%d de %B às %H:%Mh")),
        h(event.end_at.strftime("%d de %B às %H:%Mh")),
        distance_of_time_in_words(event.start_at,event.end_at)        
      ]
    end
  end

  def events
    puts "EVENTS: #{@events.inspect}"
    @events ||= fetch_events
  end

  def fetch_events
    puts "FETCHING EVENTS"
    puts @salon.inspect    
    events = @salon.events.includes(:client,:professional).order("#{sort_column} #{sort_direction}")    
    events = events.today if params[:date] == "today"
    events = events.mine(current_professional.id) if params[:professional]   
    if params[:past_events]
      events = events.scoped
    else
      events = events.from_today_on
    end    


    events = events.page(page).per(per_page)
    if params[:sSearch].present?
      events = events.where("id like :search ", search: "%#{params[:sSearch]}%")
    end
    events
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[id start_at end_at]    
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end