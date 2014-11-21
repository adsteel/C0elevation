function ajaxCalcTotal() {
	var $nop = $('#input_nop').val();
	$.ajax({
		type: 'POST',
		url: 'total',
		data: { nop: $nop },
		dataType: "script",
		beforeSend: function() {
			$('#calculate-total').text('calculating ...');
		},
		success: function(data) {
			console.log("nop is " + $nop);
		},
		error: function() {
			console.log("Calculation request error.");
		},
		complete: function() {
			$('#calculate-total').text('Calculate total');
		}		
	});
}

function ajaxDates() {
	var $id = $('#order_item_trip_date_id option:selected').val();
	var new_max;
	$.ajax({
		type: 'POST',
		url: 'dates',
		data: { id: $id },
		dataType: "script",
		beforeSend: function() {
			$('#input_nop').hide().after('<p class="date-standby">Getting date information...</p>');
		},
		success: function(data) {
			
		},
		error: function() {
			console.log("Date request error.");
		},
		complete: function() {
			runValidations();
			$('.date-standby').remove();
			$('#input_nop').show();
			$('#nop-input-error').text("");
		}		
	});

}

// Auto calculate the total when the number of people changes

var min,
	max,
	$mouseUpCounter = 0;


//    client side validations    //

function checkValidDate() {
	var date = $('#order_item_trip_date_id option:selected').text();
	if (date == "Select a Date") {
		$('#date-input-error').text("Please select a date.");
		return false;
	} else if( $('#no_dates').length ) {
		$('#date-input-error').text("");
		$('#nop-input-error').text("");
		$('#add_to_cart').prop('disabled', true);
		return false;
	} else {
		$('#date-input-error').text("");
		return true;
	}
}

function checkAllowSubmit() {
	var people = $('#input_nop').val();
	var date = $('#order_item_trip_date_id option:selected').text();
	min = $('#min').data('min');
	max = $('#max').data('max');
	if (people < min || people > max || date == "Select a Date") {
		$('#add_to_cart').prop('disabled', true);
		return false;
	} else {
		$('#add_to_cart').prop('disabled', false);
		return true;
	}
}

function checkNumberOfPeople() {
	var people = $('#input_nop').val();
	if (people < min) {
		$('#nop-input-error').text("Please enter at least " + min + " participant.");
		return false;
	} else if (people > max) {
		$('#nop-input-error').text("Only " + max + " slots remaining.");
		return false;
	} else {
		$('#nop-input-error').text("");
		return true;
	}
}

function checkDateOwnership() {
	var date_ids = $('#ids').data('ids');
	var date_id = $('#order_item_trip_date_id option:selected').val();
	if($.inArray(date_id, date_ids) > -1){
	    console.log(date_id + " is in there!");
	    var nop = $('#id_' + date_id).data('number');
	    $('#input-nop').val(nop);
	} else {
		$('#input-nop').val("");
	}
}

function formIsValid() {
	if(checkNumberOfPeople() && checkValidDate() && checkAllowSubmit() ) {
		$('#add_to_cart').prop('disabled', false);
		return true;
	} else {
		$('#add_to_cart').prop('disabled', true);
		return false;
	}
}

function runValidations() {
	checkNumberOfPeople();
	checkValidDate();
	checkAllowSubmit();
	formIsValid();
}


$(document).ready(function () {
	
	if( $('#no_dates').length ) {
		$('#add_to_cart').prop('disabled', true);
		$('#non_dates').hide();			
	}


// Scroll to customize 

  $('#go-customize').click(function (e) {
     $('html, body').animate({
       'scrollTop':   $('#customize').offset().top - 70
     }, 1000);
		 e.preventDefault();
  });
	
	//    submit request    //
	
		$('#request_submit').click(function(e) {
			console.log("submitted");
			
			$(this).parents('form').submit();
			$(this).hide().after("<a class='btn btn-default' id='sending_button'>Sending</a>");
			$('#sending_button').attr("disabled", true);
			$('#cancel_request_button').attr("disabled", true).hide();
		});

  //    listeners    //


	$('#calculate-total').click(function() {
		runValidations();
	});

	$('#input_nop').keyup( function () {
		runValidations();
	});

	$('#input_nop').blur( function () {
		runValidations();
	});

	$('#order_item_trip_date_id').change( function() {
		ajaxDates();
	});

	$('#new_order_item').submit( function(e) {
		console.log('check');
		if (formIsValid()) {
			$('#add_to_cart').text("submitting...").prop('disabled', true);
			return;
		}
		e.preventDefault();
		runValidations();
	});

/* initialize responsives slides */

  $(".rslides").responsiveSlides();
  console.log("Responsive slides attached to .rslides");

	$(function() {
		$(".rslides").responsiveSlides({
			manualControls: '#slider3-pager',
			nav: true,
			speed: 500,
			namespace: "centered-btns",
			pause: true
			});
		});

	 $('.fixedheader').affix({offset:{ top:0 }});

	$(function () { 
		var sliderheight=$('#sliderWrapper').height();
		$('#TripHeader').css( { 'min-height': sliderheight + 30})			
	});

});