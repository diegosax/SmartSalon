#encoding: utf-8

class UserMailer < ActionMailer::Base
  #include Resque::Mailer
  default from: "notification@instanapp.com"

  def registration_notice(user)  
  	@user = user
    mail(:to => user.email, :subject => "Cadastro realizado com sucesso")  
  end

  def registration_by_salon_notice(user,salon)
  	@user = user
  	@salon = salon
  	mail(:to => @user.email, :subject => "Você acaba de ser cadastrado no Instanap")  
  end
end
