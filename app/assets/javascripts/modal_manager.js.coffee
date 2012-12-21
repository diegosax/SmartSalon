$ ->	
	# called from a bootstrap dropdown, this closes the dropdown
	$('a[data-toggle=modal]').on 'click', ->
		$('.dropdown').removeClass('open')

	# this sets up the ajax loader, and it will stay until the method specific js removes it
	$('a[data-toggle=remote-modal]').on 'click', (e) ->		
		$('body').modalmanager('loading')
	$("form[data-remote=true]").submit ->
		#$('body').modalmanager('loading')
	
	#----------- New Client Modal Search ----------------------
	client_modal = $("#new_client");
	shown_div = $("#new_client .modal-body .select_client.active")	
	
	client_modal.find("form").submit (e) ->
		client_modal.modal("loading")

	shown_div.find("a.back_to_form").live "click", ->
		shown_div.find(".registered-result").fadeOut().empty()
		client_modal.find(".modal-footer .btn-primary").fadeOut().remove()
		shown_div.find(".registered-search").fadeIn()	

	$("#new_client .registered-result a.btn-primary").live "click", (e)-> 
		e.preventDefault()				
		client_modal.modal("loading")
		client_id = $("#new_client tr.client_info").attr("data-id")
		$.ajax({
			type: 'POST',
			url: "/admin/clients/" + client_id + "/add/to/salon",					
			dataType: "script"
			});
	# Associate service to professional
	associate_service_modal = $("#ajax-modal")
	associate_service_modal.on "shown", ->
		associate_service_modal.find("form").submit (e) ->			
			associate_service_modal.modal("loading")	
	
	# Working time creation
	working_time_modal = $("#new_working_time")
	working_time_modal.on "shown", ->
		working_time_modal.find("form").submit (e) ->
			working_time_modal.modal("loading")