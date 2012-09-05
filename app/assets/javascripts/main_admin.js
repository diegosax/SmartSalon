$(document).ready(function(){
	$(".new_remote_event").live("click",function(event){
		event.preventDefault();
		$("#newEvent").modal("show");
	});

	$("#newEvent").on('shown',function(){
		var now = new Date().toString("dd-MM-yyyy HH:mm");				
		
		$('#datetime_from').datetime({
			value: now,
			format: 'dd-mm-yy hh:ii',
			altField: '#datetime_from_alt', 
			altFormat: "d 'de' MM yy 'às' hh:ii", 
			chainTo: '#datetime_to', 
			chainOptions: { value: '' } });
		$('#datetime_to').datetime({
			format: 'dd-mm-yy hh:ii',
			altField: '#datetime_to_alt', 
			altFormat: "d 'de' MM yy 'às' hh:ii" 
		});
	});

//	$("#new_admin_event_form").on("submit",function(e){
		//$("#newEvent .modal-body").html("");		
	//});
});