$(document).ready(function(){	
	// -----------Masks ---------------------------------//
	$("input.phone").mask("(99) 9999-9999");


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

/*----------- New Client Modal Search ----------------------*/	

var shown_div = $("#new_client .modal-body .select_client:not(.hidden)");
shown_div.find("form").submit(function(e){
	addLoading(shown_div);
	shown_div.find("form").fadeOut("fast");
});

shown_div.find("a.back_to_form").live("click", function(){
	shown_div.children("div").remove();
	shown_div.children("form").fadeIn();	
});

$("#new_client .modal-footer a.btn-primary").live("click",function(e){
	e.preventDefault();		
	var selectedRadio = $("#new_client input[type=radio]:checked");
	if (selectedRadio.val() == "registered"){
		var client_id = $("#new_client tr.client_info").attr("data-id");
		$.ajax({
			type: 'POST',
			url: "/admin/clients/" + client_id + "/add/to/salon",						
			dataType: "script"
		});
	} else if (selectedRadio.val() == "not_registered"){

	} else if (selectedRadio.val() == "not_sure"){

	}
});

});
