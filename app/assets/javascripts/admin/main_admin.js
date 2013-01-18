$(document).ready(function(){	
	// -----------Masks ---------------------------------//
	$("input.phone").mask("(99) 9999-9999");
	$("input.zipcode").mask("99.999-999");

	//------------ Client Management | Search Registered --------//

	$("#client_celphone").blur(function(){
		var celphone = $(this).val();
		$.get("/admin/clients/search", {celphone: celphone}, {}, "script");
	});

	// ----------------------------------------------------------//

	//------------Filterable Tables ---------------------//
	$(function(){		
		var activeTab = $('[href=' + location.hash + ']');
		activeTab && activeTab.tab('show');	
	});

	$(".stats-container li a").live("click",function(){
		history.pushState(null,"",$(this).attr("href"));
		var activeTab = $('[href=' + location.hash + ']');
		activeTab && activeTab.tab('show');	
	});

	$(".dashboard_tables ul li a").live("click",function(){
		history.pushState(null,"",$(this).attr("href"));
	});

	/* ----------Payment Details Modal -------------------*/	

	$("#payment_type_boleto").live("click",function(){
		$("#payment-modal fieldset").slideUp();		
	});

	$("#payment_type_cartao").live("click", function(){		
		if ($("#payment-modal fieldset").is(":hidden")){			
			$("#payment-modal fieldset").slideDown();
		}
	});
	/*
	$("#submit-btn").live("click",function(e){
		e.preventDefault();
		$(this).attr("disabled","disabled");
		$(this).text("Processando...");
		addLoading($("#payment-modal .modal-body"));
		$("#payment-modal form").submit();		
	});
*/
$("#payment-modal form").submit(function(){		
	return false;
});

$("#payment-modal form .controls img").live("click", function(){
	$("#payment-modal form .controls img").removeClass("selected");
	$(this).addClass("selected");
});



});
