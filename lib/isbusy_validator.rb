class IsbusyValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)    
    events = Event.where("(start_at <= ? and end_at > ?) or (start_at < ? and end_at >= ?)",object.start_at,object.start_at,object.end_at,object.end_at).all
    events.each do |event|
      if event.id == object.id && events.count == 1
        return
      end
    end
    unless events.blank?
      object.errors[attribute] << (options[:message] || "entrou em conflito")
    end
  end
end
