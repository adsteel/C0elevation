$(document).ready(function() {
	$('#header').css('min-height', function () {
		return $(this).height();
	});
	$('.main-header').affix({
		offset: {
			top: function() {
			return (this.top = $('.top-header').outerHeight(true))
	  		}
		}
	});
 });