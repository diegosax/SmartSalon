$(document).ready(function(){
	$(".confirmable").live("click",function(event){
		$("#confirmation-modal .modal-body p").html($(this).attr("data-message"));
		$("#confirmation-modal .link").attr("data-destination",$(this).attr("href"));
		$("#confirmation-modal").modal('show');
	});
});