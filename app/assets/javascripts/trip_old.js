// jQuery(function($) {


// // hide what only might come out later

	
// //hide or show longer descriptions

// 	$('.see-more').click( function() {
// 		var div = $(this).parent('div.fadeout');
// 		var parent_div = div.parent('div.item-summary');
// 		var cur_height = parent_div.height();
// 		parent_div.css('height', '100%');
// 		var auto_height = parent_div.height();
// 		parent_div.height(cur_height).animate({height: auto_height}, 1000);
// 		div.fadeOut(1000);
// 	});



// //Auto calculate the total when the number of people changes

// 	var first = 250, second = 150, total;

// 	function calcTotal() {
// 			var people = $('.number-of-people').val()
// 			if (people <= 0)
// 				total = 0;
// 			else if (people == 1)
// 				total = first;
// 			else
// 				total = first + (second * (people - 1));
// 			$('#order-total').text("$" + total);
// 	}

// 	$('.number-of-people').val(1);

// 	calcTotal();

// 	$('.number-of-people').keyup( function () {
// 		calcTotal();
// 	});





// // - - - - - - - - - - - - - - - - - - - - //
// //                                         //
// //           Modal functionality           //
// //                                         //
// // - - - - - - - - - - - - - - - - - - - - //


// 	$('.fa-difficulty').click( function () {
// 		modal.open({content: "<p>Description of difficulties</p>"});
// 	});



// 	var modal = (function(){
// 	    var 
// 	    method = {},
// 	    $overlay,
// 	    $modal,
// 	    $content,
// 	    $close;

// 	    $overlay = $('<div id="overlay"></div>');
// 		$modal = $('<div id="modal"></div>');
// 		$content = $('<div id="content"></div>');
// 		$close = $('<a id="close" href="#">close</a>');

// 		$modal.hide();
// 		$overlay.hide();
// 		$modal.append($content, $close);

// 		$(document).ready(function(){
// 			$('body').append($overlay, $modal);
// 		});

// 	    // Center the modal in the viewport
// 		method.center = function () {
// 			var top, left;

// 			top = Math.max($(window).height() - $modal.outerHeight(), 0) / 2;
// 			left = Math.max($(window).width() - $modal.outerWidth(), 0) / 2;

// 			$modal.css({
// 				top:top + $(window).scrollTop(), 
// 				left:left + $(window).scrollLeft()
// 			});
// 		};

// 	    // Open the modal
// 		method.open = function (settings) {
// 			$content.empty().append(settings.content);

// 			$modal.css({
// 			    width: settings.width || 'auto', 
// 			    height: settings.height || 'auto'
// 			});

// 			$overlay.css("z-index", 6);
// 			$modal.css("z-index", 7);

// 			method.center();

// 			$(window).bind('resize.modal', method.center);

// 			$modal.show();
// 			$overlay.show();
// 		};

// 	    // Close the modal
// 	    method.close = function () {
// 			$modal.hide();
// 			$overlay.hide();
// 			$content.empty();
// 			$(window).unbind('resize.modal');
// 		};

// 	    return method;

// 		$('body').click(function(e){
// 			e.preventDefault();
// 			method.close();
// 		});


// 	}());

// });

