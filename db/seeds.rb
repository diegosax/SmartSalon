#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Salon.destroy_all
Professional.destroy_all
Service.destroy_all
Event.destroy_all
Client.destroy_all

Salon.create(
	:name => "Espaço 560",
	:username => "espaco560",
	:fone => "34661162",
	:address => "Av Cons Aguiar, 1212",
	:neighborhood => "Boa Viagem",
	:city => "Recife",
	:state => "PE",
	:zipcode => "51021020",
	:email => "espaco560@gmail.com"
)

Salon.create(
	:name => "Josymar Cabeleleiros",
	:username => "josymarcabeleleiros",
	:fone => "32249098",
	:address => "Av Dantas Barreto, 507 Sl 02",
	:neighborhood => "Santo Antônio",
	:city => "Recife",
	:state => "PE",
	:zipcode => "50010360",
	:email => "josymarcab@gmail.com"
)

Salon.create(
	:name => "China Cabeleireiros",
	:username => "chinacabeleireiros",
	:fone => "32438210",
	:address => "Pç Lula Cabral Melo, 68 Lj 4 Ga Via Roma Center",
	:neighborhood => "Parnamirim",
	:city => "Recife",
	:state => "PE",
	:zipcode => "52060141",
	:email => "chinacab@gmail.com"
)
puts "Saloes criados!"
espaco560 = Salon.find_by_username("espaco560")
josymarcabeleleiros = Salon.find_by_username("josymarcabeleleiros")
chinacabeleireiros = Salon.find_by_username("chinacabeleireiros")

puts "Criando profissionais dos saloes"
espaco560.professionals.create(
	:name => "Jessica Almeida",
	:email => "jessica@instanap.com",
	:password => "123456",
	:password_confirmation => "123456"
)

puts "primeiro profissional criado"
espaco560.professionals.create(
	:name => "Vanessa Alves",
	:email => "vanessa@instanap.com",
	:password => "123456",
	:password_confirmation => "123456"
)

espaco560.professionals.create(
	:name => "Carla Mendes",
	:email => "carla@instanap.com",
	:password => "123456",
	:password_confirmation => "123456"
)
espaco560.professionals.create(
	:name => "Roberta Justus",
	:email => "roberta@instanap.com",
	:password => "123456",
	:password_confirmation => "123456"
)
espaco560.professionals.create(
	:name => "Karen Something",
	:email => "karen@instanap.com",
	:password => "123456",
	:password_confirmation => "123456"
)
puts "Ultimo profissional criado"

puts "Criando os servicos"
espaco560.services.create(
	:name => "Corte Masculino",
	:duration => 30	
)
puts "Primeiro servico criado"
espaco560.services.create(
	:name => "Corte Feminino",
	:duration => 60	
)
espaco560.services.create(
	:name => "Escova",
	:duration => 90	
)
espaco560.services.create(
	:name => "Pé",
	:duration => 15	
)
espaco560.services.create(
	:name => "Mão",
	:duration => 15	
)
espaco560.services.create(
	:name => "Pé + Mão",
	:duration => 30	
)
espaco560.services.create(
	:name => "Hidratação",
	:duration => 120
)

espaco560.services.create(
	:name => "Coloração",
	:duration => 150
)

espaco560.services.create(
	:name => "Baby Lis",
	:duration => 45
)

espaco560.services.create(
	:name => "Depilação",
	:duration => 60
)

espaco560.services.create(
	:name => "Barba",
	:duration => 20
)

espaco560.services.create(
	:name => "Maquiagem",
	:duration => 45
)

espaco560.services.create(
	:name => "Massagem",
	:duration => 30
)
puts 'Ultimo servico criado'

professionals = espaco560.professionals
services = espaco560.services
i = 0
max = professionals.count
services.each do |p|
	p.professionals.push professionals[i%max]
	i=i+1
end