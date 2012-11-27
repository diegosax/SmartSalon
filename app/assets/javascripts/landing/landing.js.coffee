# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# elastislide carousel script starts
jQuery ->
	$('#carousel').elastislide
    	imageW    : 300
    	margin    : 20
    	border    : 0
    	easing    : 'easeInBack'	

# elastislide carousel script ends

# prettyPhoto script starts
jQuery ->
	$('a[data-rel]').each ->
		$(@).attr 'rel', $(@).data('rel')
	$("a[rel^='prettyPhoto[gallery1]']").prettyPhoto
	    animation_speed: 'fast'
	    slideshow: 5000
	    autoplay_slideshow: false
	    opacity: 0.80
	    show_title: false
	    theme: 'pp_default'
	    overlay_gallery: false
	    social_tools: false
	    changepicturecallback: ->
	    	$pp = $('.pp_default')
	    	if parseInt( $pp.css('left') ) < 0
	    		$pp.css 'left', 0
	    	    
# prettyPhoto script ends

# flexslider script starts
jQuery ->
    if $(window).width() < 959
        $('#slider').flexslider
            directionNav: true
            controlNav: false    
    else
        $('#thumb-slider').flexslider
            animation: "slide"
            controlNav: false
            animationLoop: false
            slideshow: true
            directionNav: false            
            itemWidth: 180
            itemMargin: 0
            asNavFor: '#slider'
        $('#slider').flexslider
            animation: "slide"
            controlNav: false
            directionNav: false
            animationLoop: true
            slideshow: true
            sync: "#thumb-slider"
            

# flexslider script ends