#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Professional.create(
#	:name => "Jessica Almeida",
#	:email => "jessica@instanap.com",
#	:password => "123456",
#	:password_confirmation => "123456"
#)
#Professional.create(
#	:name => "Vanessa Alves",
#	:email => "vanessa@instanap.com",
#	:password => "123456",
#	:password_confirmation => "123456"
#)
#Professional.create(
#	:name => "Carla Mendes",
#	:email => "carla@instanap.com",
#	:password => "123456",
#	:password_confirmation => "123456"
#)
#Professional.create(
#	:name => "Roberta Justus",
#	:email => "roberta@instanap.com",
#	:password => "123456",
#	:password_confirmation => "123456"
#)
#Professional.create(
#	:name => "Karen Something",
#	:email => "karen@instanap.com",
#	:password => "123456",
#	:password_confirmation => "123456"
#)

Service.create(
	:name => "Corte Masculino",
	:duration => 30	
)
Service.create(
	:name => "Corte Feminino",
	:duration => 60	
)
Service.create(
	:name => "Escova",
	:duration => 90	
)
Service.create(
	:name => "Pé",
	:duration => 15	
)
Service.create(
	:name => "Mão",
	:duration => 15	
)
Service.create(
	:name => "Pé + Mão",
	:duration => 30	
)
Service.create(
	:name => "Hidratação",
	:duration => 120
)

professionals = Professional.all
services = Service.all
i = 0
max = services.count
professionals.each do |p|
	p.services.push services[i%max]
	i=i+1
end