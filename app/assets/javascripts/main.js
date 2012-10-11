function showNoticeMessage(msg){
	var noty = noty({text: 'noty - a jquery notification library!'});	
}

function showDefaultLoadingModel(){
	$("#loading-modal").modal();
}

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
	if ($("#client_calendar").length > 0){
		$("#client_calendar tr td").addClass("unavailable");
		$("#client_calendar tr td.future").removeClass("unavailable").addClass("full");	
		$("#client_calendar tr td.future").removeClass("unavailable").addClass("full");
		
		var htmlDivMorning = "<div class='morning'>" + 
		"<a href='#' class='time-choose'>Manhã</a>" + 
		"<ul class='dropdown-time-list'></ul></div>";
		var htmlDivAfternoon = "<div class='afternoon'>" + 
		"<a href='#' class='time-choose'>Tarde</a>" + 
		"<ul class='dropdown-time-list'></ul></div>";
		var htmlDivNight = "<div class='night'>" + 
		"<a href='#' class='time-choose'>Noite</a>" + 
		"<ul class='dropdown-time-list'></ul></div>";		
		var free_dates = $("#client_calendar tr td ul");
		free_dates.each(function(i){
			var calendarItem = $(this).closest("td");
			$(calendarItem).removeClass("unavailable").addClass("free");
			$(calendarItem).find(".not_visible").append(htmlDivMorning);
			$(calendarItem).find(".not_visible").append(htmlDivAfternoon);
			$(calendarItem).find(".not_visible").append(htmlDivNight);
			var hours = $(this).find("li");
			hours.each(function(){
				var hour = parseFloat($(this).find("a").text());
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
					$(this).closest("div").remove();
					//$(this).parent().find("li").remove();
				}
			});			

			//$(calendarItem).find(".btn-group").wrapAll("<div class='btn-actions' />")
			
		});

	}	
}

function addLoading(element){
	var html = "<div class = 'loading'>Processando, por favor aguarde...<br /><img src='/assets/ajax_loader.gif'></img>"
	$(element).append(html).fadeIn("slow");
}
function addLoadingSimple(element){
	var html = "<img src='/assets/ajax_loader.gif'></img>"
	$(element).html(html);
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
	$.ajax(window.location.pathname, {
			data: $("#new-event-form").serialize(),
			dataType: "script"
		});
	history.pushState(null,"",window.location.pathname + "?" + $("#new-event-form").serialize());
}

userList = null;
$(document).ready(function(){

	$("#client_calendar td").live({
		//hover in
		mouseenter:
		function(){
			$(this).find(".not_visible").slideDown("fast");
		},
		//hover out
		mouseleave:
		function(){
			$(this).find(".not_visible").slideUp("fast");
		}
	});

	$("#client_calendar td .not_visible a.time-choose").live('click', function(e){
		var timeList = $(this).parent().find("ul");
		if (timeList.is(":visible")){
			timeList.slideUp();
			$(this).closest("td").removeClass("active");
			$(this).closest("div").removeClass("active");
		}else{
			timeList.slideDown();		
			$(this).closest("td").addClass("active");
			$(this).closest("div").addClass("active");
		}
		e.preventDefault();
	});

	loadDateTimePicker();

	window.onpopstate = function(e) { 
		if (!(typeof e.state == 'undefined')) { 
	       //$.getScript(location.href);
	   } 
	}
	$(".chzn_a").chosen();
	$("#choose-client .chzn_a").chosen().change(function(){
		history.pushState(null,"",window.location.pathname + "?" + $("#new-event-form").serialize());
	});
	
	$("#choose-service .chzn_a").chosen().change(function(){
		$("#client_calendar").remove().fadeOut("fast");
		$("#choose-professional").remove().fadeOut("fast");
		addLoading($("#new-event-form"));
		$("#choose-professional select option[value='']").attr('selected',true);
		$.ajax(window.location.pathname, {
			data: $("#new-event-form").serialize(),
			dataType: "script"
		});
		//$("#new-event-form").submit();
		history.pushState(null,"",window.location.pathname + "?" + $("#new-event-form").serialize());
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

  	//----------------- Favorite salon ----------------------------//
  	function removeFavorite(element){
  		var id = element.closest("li").attr("data-id");
  		$.ajax({
  			type: "delete",
  			url:"/favorites/" + id,
  			dataType: "script"
  		});
  		addLoadingSimple($("#mini_grid li[data-id='" + id + "']"));
  	}
  	$(".star_fav").live("click", function(e){
  		e.preventDefault();
  		if ($(this).hasClass("favorite")){
  			removeFavorite($(this));
  		} else{
  			$.ajax({
	  			type: "post",
	  			url:"/favorites",
	  			data: {salon_id: $(this).closest("li").attr("data-id")},      
	  			dataType: "script"
  			});	
  		}
  		
  	});

  	$(".remove_favorite i").tooltip();

  	$(".remove_favorite").live("click",function(e){
  		e.preventDefault();
  		//This is line is necessary beacause there is a tooltip bug, it sticks
  		$(".remove_favorite i").tooltip("hide");
  		removeFavorite($(this));
  	});

  	//----------- MASKED INPUT ----------------//

  		$("#client_celphone").mask("(99) 9999-9999");
  		$("#professional_celphone").mask("(99) 9999-9999");
  		$("#professional_landphone").mask("(99) 9999-9999");
  		$("#professional_zipcode").mask("99.999-999");

  	//------------END MASKED INPUT ------------//

  	//------------Professional / Services Association ----------//

  	$("#new_professional_service").live("click",function(){
  		showDefaultLoadingModel();
  	});	

  	//------------END Professional / Services Association ----------//

  	//------------Address Loading ----------------------------------//

  		//ao soltar a tecla dentro do campo de cep ele verifica se possui 8 digitos e chama um posto para preenchimento do cep
    	$("#professional_zipcode").keyup(function(e){
    		var zipcode = $("#professional_zipcode").val().replace(/[^0-9]/g, '');    	    
    	    if (zipcode.length == 8){    	       	
    	        $(this).attr("disabled", true);
    	        $(".zipcode_loading").fadeIn('slow');
    	        $.post("/admin/professionals/search_zipcode", {zipcode: $(this).val()}, {}, "script");    	        
    	        $("#professional_address").focus();
    	        e.preventDefault();
    	        return false;
    	    }
    	});

  	//------------END Address Loading ------------------------------//

  });