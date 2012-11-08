class Notifier < ActionMailer::Base
  
  default :from => "instanaptests@gmail.com"
  
  def client_event_canceled(event)
    @event = event
    mail(:to => "#{event.client.name} <#{event.client.email}>", :subject => "Agendamento cancelado")
  end

  def professional_event_canceled(event)
    @event = event
    mail(:to => "#{event.professional.name} <#{event.professional.email}>", :subject => "Agendamento cancelado")
  end

  def client_event_reschedule_notification(event)
  	@event = event
    mail(:to => "#{event.client.name} <#{event.client.email}>", :subject => "Aviso de reagendamento")
  end

  def professional_event_reschedule_notification(event)
    @event = event
    mail(:to => "#{event.professional.name} <#{event.professional.email}>", :subject => "Aviso de reagendamento")
  end

  def client_event_created(event)
  	@event = event
    mail(:to => "#{event.client.name} <#{event.client.email}>", :subject => "Agendamento confirmado")
  end

  def professional_event_created(event)
    @event = event
    mail(:to => "#{event.professional.name} <#{event.professional.email}>", :subject => "Agendamento confirmado")
  end

end
