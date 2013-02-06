$(document).ready(function(){	

	// ----------- Validation Defaults ------------------//

	jQuery.validator.setDefaults({
		errorPlacement: function(error, element) {
			var isInputAppend = ($(element).parent('div.input-append').length > 0);
			var isRadio = ($(element).attr('type') == 'radio');
			if(isRadio){
				afterElement = $(element).closest('div.controls').children("label").filter(":last");
				error.insertAfter(afterElement);
			}else if (isInputAppend) {
				appendElement = $(element).next('span.add-on');
				error.insertAfter(appendElement);
			}else {
				error.insertAfter(element);
			}
		}
	});

	// --------------------------------------------------//

	// -----------Masks ---------------------------------//
	$("input.phone").mask("(99) 9999-9999");
	$("input.zipcode").mask("99.999-999");

	//------------ Client Management | Search Registered --------//

	$("#client_email").blur(function(){
		var email = $("#client_email").val();
		if (email.length > 3){
			$("#client_email").parent().find("img").fadeIn();
			$.get("/admin/clients/search", {email: email}, {}, "script");	
		}
		
	});

	// ----------------------------------------------------------//

	// ---------Service creation validation --------------------//

	$("#new_admin_service_form").validate({
		rules: {
			service_name: {
				required: true
			},
			service_price: {
				number: true
			},
			service_duration: {
				required: true,
				digits: true
			}
		}
	});

	// ---------------------------------------------------------//


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
