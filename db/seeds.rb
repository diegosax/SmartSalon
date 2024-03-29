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
	:name => "Open Hair",
	:username => "openhair",
	:landphone => "1135010199",
	:celphone => "1135010199",
	:address => "Av Giovanni Gronchi, 3363",
	:neighborhood => "Morumbi",
	:city => "São Paulo",
	:state => "SP",
	:zipcode => "05651001",
	:email => "contato@openhair.com.br"
)

Salon.create(
	:name => "Soho Academy Pinheiros",
	:username => "sohoacademy",
	:landphone => "1138133834",
	:celphone => "1195010199",
	:address => "Rua dos Pinheiros, 1376",
	:neighborhood => "Pinheiros",
	:city => "São Paulo",
	:state => "SP",
	:zipcode => "05422002",
	:email => "sohoacademy@sohohair.com.br"
)

Salon.create(
	:name => "Spettacolo",
	:username => "spettacolo",
	:landphone => "1125718022",
	:celphone => "1195718022",
	:address => "Rua Coronel Diogo, 364",
	:neighborhood => "Aclimação",
	:city => "São Paulo",
	:state => "SP",
	:zipcode => "01545000",
	:email => "spettacolo@spettacolo.com.br"
)

Salon.create(
	:name => "Espaço 560",
	:username => "espaco560",
	:landphone => "8134661162",
	:celphone => "8194661162",
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
	:landphone => "8132249098",
	:celphone => "8182249098",
	:address => "Av Dantas Barreto, 507 Sl 02",
	:neighborhood => "Santo Antônio",
	:city => "Recife",
	:state => "PE",
	:zipcode => "50010360",
	:email => "josymarcab@gmail.com"
)

puts "Criando chinacabeleireiros"
Salon.create(
	:name => "China Cabeleireiros",
	:username => "chinacabeleireiros",
	:landphone => "8132438210",
	:celphone => "8182438210",
	:address => "Pç Lula Cabral Melo, 68 Lj 4 Ga Via Roma Center",
	:neighborhood => "Parnamirim",
	:city => "Recife",
	:state => "PE",
	:zipcode => "52060141",
	:email => "chinacab@gmail.com"
)

Salon.create(
	:name => "Edelson Cabeleleiros",
	:username => "edelson",
	:landphone => "8132285606",
	:celphone => "8191385606",
	:address => "Rua Conde de Irajá, 353",
	:neighborhood => "Torre",
	:city => "Recife",
	:state => "PE",
	:zipcode => "50710310",
	:email => "edelson@gmail.com"
)

puts "Indo criar Jacques"
Salon.create(
	:name => "Jacques Janine",
	:username => "jacquesjanine",
	:landphone => "8134636368",
	:celphone => "8194636368",
	:address => "Rua Padre Carapuceiro – loja BV 271",
	:neighborhood => "Boa Viagem",
	:city => "Recife",
	:state => "PE",
	:zipcode => "51020900",
	:email => "shoppingrecife@jacquesjanine.com.br"
)

Salon.create(
	:name => "Studio Neide",
	:username => "studioneide",
	:landphone => "1120418285",
	:celphone => "1191418285",
	:address => "Rua Brook Taylor, 1065",
	:neighborhood => "Jardim Coimbra",
	:city => "São Paulo",
	:state => "SP",
	:zipcode => "03690000",
	:email => "studioneide@gmail.com"
)


espaco560 = Salon.find_by_username("espaco560")

puts "Criando profissionais dos saloes"
espaco560.professionals.create(
	:name => "Jessica Almeida",
	:email => "jessica@instanap.com",
  :celphone => "81818181",
	:password => "123456",
	:password_confirmation => "123456"
)

puts "primeiro profissional criado"
espaco560.professionals.create(
	:name => "Vanessa Alves",
	:email => "vanessa@instanap.com",
  :celphone => "81818182",
	:password => "123456",
	:password_confirmation => "123456"
)

espaco560.professionals.create(
	:name => "Carla Mendes",
	:email => "carla@instanap.com",
  :celphone => "81818183",
	:password => "123456",
	:password_confirmation => "123456"
)
espaco560.professionals.create(
	:name => "Roberta Justus",
	:email => "roberta@instanap.com",
  :celphone => "81818184",
	:password => "123456",
	:password_confirmation => "123456"
)
espaco560.professionals.create(
	:name => "Karen Something",
	:email => "karen@instanap.com",
  :celphone => "81818185",
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

puts '--------------------------------------------------------------'
puts max

services.each do |p|
	p.professionals.push professionals[i%max]
	i=i+1
end
