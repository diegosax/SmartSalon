class Notifier < ActionMailer::Base
  
  default :from => "instanaptests@gmail.com"
  
  def event_canceled(event)
    @event = event
    mail(:to => "#{event.client.name} <#{event.client.email}>", :subject => "Agendamento cancelado")
  end
end
