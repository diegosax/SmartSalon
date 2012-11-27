###$(document).ready(function(){
	var moip_success = function(data){
		alert('Sucesso\n' + JSON.stringify(data));
	}

	var moip_failure = function(data){
		alert('Falha\n' + JSON.stringify(data));
	}

	var checkout = function(){
		alert("checkout");
	}	

});
###