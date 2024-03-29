$(document).ready(function(){	

	//-------------Datatables initialization-------------//

	// For fluid containers
	$('.datatable').dataTable({
	  	"sDom": "<'row-fluid'r>t<'row-fluid'<'span6'i><'span6'p>>",
	  	"sPaginationType": "bootstrap",
	  	"bProcessing": "true",
    	"bServerSide": "true",
    	"sAjaxSource": $('#events_list').data('source')
	});

	//---------------------------------------------------//

	// ----------- Validation Defaults ------------------//

	jQuery.validator.addMethod("multiple", function(value, element, param) { 		
		return value % param == 0; 
	}, jQuery.format("Deve ser um múltiplo de {0}"));

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

	//------------ Date and Time Pickers ----------------//

	$("[data-behaviour~='datepicker']").datepicker({
		language: "pt-BR",
		format: "dd/mm/yyyy"
	}).on("changeDate", function(){
		updateDatetime();
	});
	$("[data-behaviour~='timepicker']").timepicker({		
		minutes: {
	        starts: 0,                // First displayed minute
	        ends: 45,                 // Last displayed minute
	        interval: 15              // Interval of displayed minutes
	    },
	    onClose: function(){
	    	updateDatetime();
	    }
	});

	var updateDatetime = function(){		
		var from_date = $("#date_from_picker").val();
		var from_time = $("#time_from_picker").val();
		$("#datetime_from").val(from_date + " " + from_time);
		var to_date = $("#date_to_picker").val();
		var to_time = $("#time_to_picker").val();
		$("#datetime_to").val(to_date + " " + to_time);
		console.log("update called");
	}

	//---------------------------------------------------//

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

/*----------- Dashboard Events --------------------------*/
if ($(".task-list td.event_col li").length > 0){
	var scroolPosition = $(".task-list td.event_col li")[0].scrollHeight * 33;
	$(".task-list").scrollTop(scroolPosition);
}
$(".task-list .busy").popover();

$("#chosen_professional_day_view").chosen().change(function(){
	addLoading($(".day-view .toolbar"));
	history.pushState(null,"",window.location.pathname + "?professional=" + $("#chosen_professional_day_view").val());
	$.ajax({
		url: window.location.pathname,
		data: {
			professional: $("#chosen_professional_day_view").val()
		},
		dataType: "script"
	});
});


/*-------------------------------------------------------*/

/*---------------------Events Page --------------------- */

if ($("#calendar_view .event_col li").length > 0){
	var scroolPosition = $("#calendar_events_list .event_col li")[0].scrollHeight * 33;
	$("#calendar_events_list").scrollTop(scroolPosition);
	$('#professionals_header').css({position: 'absolute', top: $("#calendar_events_list").scrollTop()});			
}

$("#calendar_events_list").scroll(function(){	
	$('#professionals_header').css({position: 'absolute', top: $(this).scrollTop()});			
	$("#time_col").css({position: 'absolute', left: $(this).scrollLeft()});			
});

$(".busy").live("click",function(){
	var id = $(this).attr("data-event-id");
	$.ajax({
		url: "/admin/events/" + id,		
		dataType: "script"
	});
});

$("a[data-toggle=tab]").live("click",function(e){
	history.pushState(null,"",e.target.href);	
});

/*-------------------------------------------------------*/

/*-------------------New Event --------------------------*/
/*$("#new_admin_event_form").submit(function(e){
	e.preventDefault();
	console.log('Trying to submit!');
});*/

/*-------------------------------------------------------*/

/*-------------------------------------------------------*/

});
