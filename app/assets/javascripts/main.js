function addLoading(element){
	var html = "<div class = 'loading'>Processando, por favor aguarde...<br /><img src='/assets/ajax_loader.gif'></img>"
	$(element).append(html).fadeIn("slow");
}

function removeLoading(){
	$(".loading").remove().fadeOut("fast");
}
function loadDateTimePicker(){
	var minu = (60 - (new Date().getMinutes()))%5;
	$('#datetime_from').datetime({value: '+'+minu+'min',format: 'dd-mm-yy hh:ii',altField: '#datetime_from_alt', altFormat: "d 'de' MM yy 'às' hh:ii", chainTo: '#datetime_to', chainOptions: { value: '' } });
	$('#datetime_to').datetime({format: 'dd-mm-yy hh:ii',altField: '#datetime_to_alt', altFormat: "d 'de' MM yy 'às' hh:ii"});
	$('#datetime_atualizacao_data').datetime({value: '+1min',format: 'dd-mm-yy hh:ii',altField: '#datetime_atualizacao_data_alt', altFormat: "d 'de' MM yy 'às' hh:ii" });
}

function onChooseProfessionalChange(){
	$("#calendar").remove().fadeOut("fast");		
	addLoading($("#new-event-form"));
	$("#new-event-form").submit();
	history.pushState(null,"",$("#new-event-form").attr("action") + "?" + $("#new-event-form").serialize());
}
$(document).ready(function(){

	//----------------------------------------------------------------------------------------
    //Preparando a requisicao ajax para ser enviada como javascript
    //jQuery.ajaxSetup({
    //    'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
    //});
    //Fim da preparacao da requisicao ajax
	//----------------------------------------------------------------------------------------------------

	window.onpopstate = function(e) { 
		if (!(typeof e.state == 'undefined')) { 
	       //$.getScript(location.href);
	   } 
	}

	

	loadDateTimePicker();


	$(".day_number a").live("click",function(){
		$("#newEvent").modal("show");
	});

	Tipped.setDefaultSkin('light');

	$('.event').each(function(index){
		Tipped.create(this,$(this).find("a").attr("href"), {
			ajax: true,
			closeButton: true,
			hideOn: 'click-outside',
			closeButtonSkin: 'light',
			hideOthers: true,
			showOn: 'click',
			spinner: {
				radii:     [32, 42],
				color:     '#808080',
				dashWidth: 1,
				dashes:    75,
				speed:     .7
			},
			hook: {
				target: 'rightmiddle',
				tooltip: 'lefttop'
			},
			skin: 'light'			
		});   
	});

	$('.event a').live("click",function(event){
		event.preventDefault();
	});

	$("a[data-remote=true]").live("click",function(event){
		$(this).closest("div").remove().fadeOut("fast");
		addLoading($("new-event-form"));
	});

	$("#newEvent").on('shown',function(){
		var now = new Date();
		var minute = now.getMinutes();
		if (minute < 10){
			minute = "0" + minute;
		}
		var hora = now.getHours() + ":" + minute;
		var date = document.URL.split('#')[1] + " " + hora;
		
		$('#datetime_from').datetime({value: date,format: 'dd-mm-yy hh:ii',altField: '#datetime_from_alt', altFormat: "d 'de' MM yy 'às' hh:ii", chainTo: '#datetime_to', chainOptions: { value: '' } });
		$('#datetime_to').datetime({format: 'dd-mm-yy hh:ii',altField: '#datetime_to_alt', altFormat: "d 'de' MM yy 'às' hh:ii", });
	});	

	$("#choose-service .chzn_a").chosen().change(function(){
		$("#calendar").remove().fadeOut("fast");
		$("#choose-professional").remove().fadeOut("fast");
		addLoading($("#new-event-form"));
		$("#choose-professional select option[value='']").attr('selected',true);
		$("#new-event-form").submit();
		history.pushState(null,"",$("#new-event-form").attr("action") + "?" + $("#new-event-form").serialize());
	});

	$("#choose-professional .chzn_a").chosen().change(function(){
		onChooseProfessionalChange();
	});

	$("#new-event-form").on("submit",function(){
		history.pushState(null,"",$(this).attr("action") + "?" + $(this).serialize());
	});

	$(".new-event-link").live('click',function(event){
		event.preventDefault();
		$(this).parent("li").attr("class","remove");
		//$("#confirmation-modal .modal-body p").html($(this).attr("data-message"));
		//$("#confirmation-modal .link").attr("data-link",$(this).attr("href"));
		//$("#confirmation-modal").modal('show');
	});

	$("#save-event-btn").live("click",function(event){
		event.preventDefault();
		$("#confirmation-modal .modal-body p").html("Processando, por favor aguarde...<br /><img src='/assets/ajax_loader.gif'></img>");
		$.post($("#confirmation-modal .link").attr("data-link"),{},"html");		
	});

	$("#confirmation-modal").on("hide", function(){
		$("#calendar li.remove").removeClass("remove");
		
	});
});