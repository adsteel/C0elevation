$(document).ready(function() {
    var topOffsetPhone = 35;
		var $offset = 100;

		function setOffset() {
			var width = $( window ).width();
			if (width >= 1200)
			{
				$offset = 40;
			}
			else if (width >= 992 && width <= 1199)
			{
			   $offset = 30;
			}
			else if (width >= 768 && width <= 991)
			{
			   $offset = 50;
			}
			else 
			{
			   $offset = 35;
			}
			console.log("Width: " + width);
		}
		
    $('#see_private').click(function (e) {
			setOffset();
      $('html, body').animate({
        'scrollTop':   $('#private').offset().top - $offset
      }, 1500);
			e.preventDefault();
    });

    $('#see_group').click(function (e) {
			setOffset();
       $('html, body').animate({
         'scrollTop':   $('#group').offset().top - $offset
       }, 1500);
			 e.preventDefault();
    });

    $('#see_private_phone').click(function (e) {
       $('html, body').animate({
         'scrollTop':   $('#private').offset().top - topOffsetPhone
       }, 1500);
			 e.preventDefault();
    });

    $('#see_group_phone').click(function (e) {
       $('html, body').animate({
         'scrollTop':   $('#group').offset().top - topOffsetPhone
       }, 1500);
			 e.preventDefault();
    });

    $('.item').mouseover(function () {
    	$(this).find('.overlay-white').addClass("item-hover-white");
    	$(this).mouseout(function () {
    		$(this).find('.overlay-white').removeClass("item-hover-white");
    	})
    	$(this).find('.overlay-black').addClass("item-hover-black");
    	$(this).mouseout(function () {
    		$(this).find('.overlay-black').removeClass("item-hover-black");
    	})
    });
});