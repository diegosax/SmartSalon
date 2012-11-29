$(document).ready(function(){
	$(".confirmable").live("click",function(event){		
		event.preventDefault();
		$("#confirmation-modal .modal-body p").html($(this).attr("data-message"));
		$("#confirmation-modal .link").attr("data-destination",$(this).attr("href"));
		$("#confirmation-modal .link").attr("data-method-type",$(this).attr("data-method-type"));		
		$("#confirmation-modal").modal('show');
	});
	$("#confirm-btn").live("click",function(event){
		event.preventDefault();
		$("#confirmation-modal .modal-body p").html("Processando, por favor aguarde...<br /><img src='/assets/ajax_loader.gif'></img>");
		var method = "post";
		if ($("#confirmation-modal .link[data-method-type]").length > 0)
			method = $("#confirmation-modal .link").attr("data-method-type");
		$.ajax({
			type: method,
			url: $("#confirmation-modal .link").attr("data-destination"),
			dataType: "script"
		});
	});

	$("#confirmation-modal").on("hide",function(){
		$("#confirmation-modal .modal-footer").html("<a href='#'' class='btn' data-dismiss = 'modal'>" + 
			"Fechar</a><a href='#'' class='btn btn-primary' id='confirm-btn'>Confirmar</a>");
	});
});