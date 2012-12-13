#encoding: utf-8
Timezone::Configure.begin do |c|
	c.default_for_list = "America/Recife",
	"America/Sao_Paulo",
	"America/Maceio",
	"America/Manaus",    
    "America/Cuiaba",
    "America/Boa_Vista",
    "America/Rio_Branco",
    "America/Fortaleza",
    "America/Belem",
    "America/Noronha",
    "America/Campo_Grande",
    "America/Bahia"
 	c.replace "America/Manaus", with: "Manaus"
  	c.replace "America/Maceio", with: "Maceio"
  	c.replace "America/Sao_Paulo", with: "São Paulo"
  	c.replace "America/Cuiaba", with: "Cuiabá"
  	c.replace "America/Boa_Vista", with: "Boa Vista"
  	c.replace "America/Rio_Branco", with: "Rio Branco"
  	c.replace "America/Fortaleza", with: "Fortaleza"
  	c.replace "America/Belem", with: "Belém"
  	c.replace "America/Noronha", with: "Fernando de Noronha"
  	c.replace "America/Campo_Grande", with: "Campo Grande"
  	c.replace "America/Bahia", with: "Bahia"
  	c.replace "America/Recife", with: "Recife"
end
