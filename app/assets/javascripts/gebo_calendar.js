/* [ ---- Gebo Admin Panel - calendar ---- ] */

$(document).ready(function() {
	gebo_calendar.init();
		//* resize elements on window resize
		var lastWindowHeight = $(window).height();
		var lastWindowWidth = $(window).width();
		$(window).on("debouncedresize",function() {
			if($(window).height()!=lastWindowHeight || $(window).width()!=lastWindowWidth){
				lastWindowHeight = $(window).height();
				lastWindowWidth = $(window).width();
				//* rebuild calendar
				$('#calendar').fullCalendar('render');
			}
		});
	});

	//* calendar
	gebo_calendar = {
		init: function() {
			var date = new Date();
			var d = date.getDate();
			var m = date.getMonth();
			var y = date.getFullYear();
			var calendar = $('#calendar').fullCalendar({
				header: {
					left: 'prev next',
					center: 'title,today',
					right: 'month,agendaWeek,agendaDay'
				},
				buttonText: {
					prev: '<i class="icon-chevron-left cal_prev" />',
					next: '<i class="icon-chevron-right cal_next" />'
				},
				aspectRatio: 1.5,
				selectable: true,
				selectHelper: true,
				/*select: function(start, end, allDay) {
					var title = prompt('Event Title:');
					if (title) {
						calendar.fullCalendar('renderEvent',
						{
							title: title,
							start: start,
							end: end,
							allDay: allDay
						},
							true // make the event "stick"
							);
					}
					calendar.fullCalendar('unselect');
				},
				
				editable: true,
				*/
				theme: false,
				events: {
					url: "/admin/events/get_events",
					className: "event target"
				},
				slotMinutes: 15,
				allDaySlot: false,
				firstHour: 8,
				maxTime:22,
				//timeFormat: 'h:mm t{ - h:mm t} ',
				eventColor: '#bcdeee',
				eventAfterRender: function(event, element, view ) { 
					Tipped.create(element,element.attr("href") + ".js", {
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
							speed:     .75
						},
						hook: {
							target: 'rightmiddle',
							tooltip: 'lefttop'
						},
						skin: 'light'			
					});
				},
				eventClick: function(event) {
					return false;
				},
				dayClick: function(e) {
					$("#calendar").fullCalendar(
					 	'gotoDate', e
					);	
        			$("#calendar").fullCalendar('changeView', "basicDay" )
    			}
			})
	}
};