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

end
