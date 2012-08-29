function clearSalonSearchResults(){
	$("#large_grid").empty();
}

function forceResize(){
	if($(window).width() <= 979){
		$(".chzn-done").show();
	} else{
		$(".chzn-done").hide();
	}
}

function addToHourList(item,period,calendarItem){	
	$(calendarItem).find("div." + period + " ul").append(item);
}

function prettyCalendar(){
	console.log("prettyCalendar Chamado");
	if ($("#client_calendar").length > 0){
		$("#client_calendar tr td").addClass("unavailable");
		$("#client_calendar tr td.future").removeClass("unavailable").addClass("full");	
		$("#client_calendar tr td.future").removeClass("unavailable").addClass("full");
		
		var htmlButtonMorning = "<div class='btn-group morning'> \
		<button data-toggle='dropdown' class='btn dropdown-toggle btn-mini'> \
		Manhã \
		</button><ul class='dropdown-menu morning'></ul></div>";
		var htmlButtonAfternoon = "<div class='btn-group afternoon'> \
		<button data-toggle='dropdown' class='btn dropdown-toggle btn-mini'> \
		Tarde \
		</button><ul class='dropdown-menu afternoon'></ul></div>";
		var htmlButtonNight = "<div class='btn-group night'> \
		<button data-toggle='dropdown' class='btn dropdown-toggle btn-mini'> \
		Noite \
		</button><ul class='dropdown-menu night'></ul></div>";
		var free_dates = $("#client_calendar tr td ul");
		free_dates.each(function(i){
			var calendarItem = $(this).closest("td");
			$(calendarItem).removeClass("unavailable").addClass("free");
			$(calendarItem).append(htmlButtonMorning);
			$(calendarItem).append(htmlButtonAfternoon);
			$(calendarItem).append(htmlButtonNight);
			var hours = $(this).find("li");
			hours.each(function(){
				var hour = parseFloat($(this).text());
				if (hour >=0 && hour < 12){
					addToHourList($(this),"morning",calendarItem);
				} else if (hour >= 12 && hour < 18){
					addToHourList($(this),"afternoon",calendarItem);
				} else{
					addToHourList($(this),"night",calendarItem);
				}
			});			
			$(this).remove();
			$(calendarItem).find("ul").each(function(){
				if ($(this).find("li").length == 0){
					//$(this).closest("div").remove();
					$(this).parent().find("button").attr("disabled",true);
				}
			});

			$(calendarItem).find(".btn-group").wrapAll("<div class='btn-actions' />")
			
		});

	}	
}

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
	$("#client_calendar").remove().fadeOut("fast");		
	addLoading($("#new-event-form"));
	$("#new-event-form").submit();
	history.pushState(null,"",$("#new-event-form").attr("action") + "?" + $("#new-event-form").serialize());
}

userList = null;
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
		addLoading($("#new-event-form"));
	});

	

	$("#choose-service .chzn_a").chosen().change(function(){
		$("#client_calendar").remove().fadeOut("fast");
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
		$("#client_calendar li.remove").removeClass("remove");
		
	});

	//-------------User Events List ------------------------//
	//*typeahead
	var list_source = ['sl_service', 'sl_professional'];
	/*$('.user_list li').each(function(){
		var search_name = $(this).find('.sl_service').text();
		var search_professional = $(this).find('.sl_professional').text();
		list_source.push(search_name);
	});
*/
	//$('.user-list-search').typeahead({source: list_source, items:10});	

	var pagingOptions = {};
	var options = {
		valueNames: [ 'sl_id','sl_name', 'sl_professional'],
		page: 10,
		plugins: [
		[ 'paging', {
			pagingClass	: "bottomPaging",
			innerWindow	: 1,
			left		: 1,
			right		: 1
		} ]
		]
	};
	userList = new List('user-list', options);

	$('#filter-online').on('click',function() {
		$('ul.filter li').removeClass('active');
		$(this).parent('li').addClass('active');
		userList.filter(function(item) {
			if (item.values().sl_status == "online") {
				return true;
			} else {
				return false;
			}
		});
		return false;
	});
	$('#filter-offline').on('click',function() {
		$('ul.filter li').removeClass('active');
		$(this).parent('li').addClass('active');
		userList.filter(function(item) {
			if (item.values().sl_status == "offline") {
				return true;
			} else {
				return false;
			}
		});
		return false;
	});
	$('#filter-none').on('click',function() {
		$('ul.filter li').removeClass('active');
		$(this).parent('li').addClass('active');
		userList.filter();
		return false;
	});

	$('#user-list').on('click','.sort',function(){
		$('.sort').parent('li').removeClass('active');
		if($(this).parent('li').hasClass('active')) {
			$(this).parent('li').removeClass('active');
		} else {
			$(this).parent('li').addClass('active');
		}
	}
	);

	//------------End OF User Events List ------------------------//

	//prettyCalendar();

	$(window).on("debouncedresize",function() {
		forceResize();
	});
	
	if($(window).width() <= 979){ 
		$(".chzn-done").show();
	}

	//------------------------------------------------------------//

	$('a[data-toggle="tab"]').on('shown', function (e) {
   		removeLoading(); 
   		clearSalonSearchResults();
  	});

  	$('a[href="#address-search-tab"]').on('shown', function (e) {
   		$("#address_search_well form").submit();
  	});

  	$("#address_search_well form").submit(function(e){
  		clearSalonSearchResults();
  		if ($("#location").val().length > 0){
  			addLoading($("#large_grid"));
  			return true;
  		} else{
  			return false;
  		}
  		
  	});
	
});