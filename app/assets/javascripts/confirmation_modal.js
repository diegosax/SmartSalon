$(document).ready(function(){
	$(".confirmable").live("click",function(event){
		event.preventDefault();
		$("#confirmation-modal .modal-body p").html($(this).attr("data-message"));
		$("#confirmation-modal .link").attr("data-destination",$(this).attr("href"));
		$("#confirmation-modal").modal('show');
	});
	$("#confirm-btn").live("click",function(event){
		event.preventDefault();
		$("#confirmation-modal .modal-body p").html("Processando, por favor aguarde...<br /><img src='/assets/ajax_loader.gif'></img>");
		console.log("Posting to: ") + $("#confirmation-modal .link").attr("data-destination");
		$.post($("#confirmation-modal .link").attr("data-destination"),{},"html");
	});

	$("#confirmation-modal").on("hide",function(){
		$("#confirmation-modal .modal-footer").html("<a href='#'' class='btn' data-dismiss = 'modal'>" + 
			"Fechar</a><a href='#'' class='btn btn-primary' id='confirm-btn'>Confirmar</a>");
	});
});