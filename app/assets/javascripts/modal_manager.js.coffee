$ ->	
	# called from a bootstrap dropdown, this closes the dropdown
	$('a[data-toggle=modal]').on 'click', ->
		$('.dropdown').removeClass('open')
	
	# this sets up the ajax loader, and it will stay until the method specific js removes it
	$('a[data-toggle=remote-modal]').on 'click', (e) ->		
		$('body').modalmanager('loading')	
	#removes whatever is in the modal body content div upon clicking close/outside modal
	###$(document).on 'click', '[data-dismiss=modal], .modal-scrollable', ->
		$('.modal-body-content').empty()###
	#----------- New Client Modal Search ----------------------
	modal = $("#new_client");
	shown_div = $("#new_client .modal-body .select_client:not(.hidden)")
	
	shown_div.find("form").submit (e) ->
		modal.modal("loading");
	
	shown_div.find("a.back_to_form").live "click", ->
		shown_div.children("div").fadeOut()
		shown_div.children("form").fadeIn()	
	
	$("#new_client .modal-footer a.btn-primary").live "click", (e)-> 
		e.preventDefault()
		selectedRadio = $("#new_client input[type=radio]:checked")
		if selectedRadio.val() == "registered"
			client_id = $("#new_client tr.client_info").attr("data-id")
			$.ajax({
				type: 'POST',
				url: "/admin/clients/" + client_id + "/add/to/salon",					
				dataType: "script"
			});
		else if (selectedRadio.val() == "not_registered")
			console.log("TODO")
		else if (selectedRadio.val() == "not_sure")
			console.log("TODO")

  	#------------END Client / Services Association ----------//