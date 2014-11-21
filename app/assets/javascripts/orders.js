$(document).ready(function () {


// Payment submission to Stripe

Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));

var stripeResponseHandler = function(status, response) {
  var $form = $('#new_order');

  if (response.error) {
    
    // Show the errors on the form
		console.log("response" + response.error.code)
    $form.find('.payment-errors').text(response.error.message);
    $form.find('button').prop('disabled', false);

  } else {
    // token contains id, last4, and card type
    var token = response.id;

    // Insert the token into the form so it gets submitted to the server
    $form.append($('<input type="hidden" name="stripe_card_token" id="stripe_card_token"/>').val(token));
    // and submit
    $form.get(0).submit();
    $form.find('button').prop('disabled', true).text('Processing order.');
  }
};

$('#new_order').submit(function(event) {
  var $form = $(this);

  // Disable the submit button to prevent repeated clicks
  $form.find('button').prop('disabled', true);

  Stripe.card.createToken($form, stripeResponseHandler);

  // Prevent the form from submitting with the default action
  return false;
});





// Only allows 20 minutes on the checkout page before redirecting home

var delayedRedirectToCart = function() {
    window.location = "<%= cart_path(current_user) %>"
}

if ($('body.orders.new').length) {
  console.log("We're on the new order page!");
  window.setTimeout(function() {
    window.location.href = '/';
  }, 1200000);
  $('body').click( function() {
    $('.flash-container').hide();
  })
}


// Validation functions

$('#purchase-submit').prop('disabled', true);

window.validate_credit_card = function() {
  return Stripe.card.validateCardNumber($("#credit_card").val());
}

window.validate_cvc = function() {
  return Stripe.card.validateCVC($("#cvc").val());
}

window.validate_card_name = function() {
  name = $('#card_name').val();
  if (name.length > 0) {
    return true;
  } else {
    return false;
  }
}

window.validate_card_zip = function() {
  zip = $('#card_zip').val();
  if ((zip.length > 4) && (!isNaN(zip))) {
    return true;
  } else {
    return false;
  }
}

window.validate_date = function() {
  card_month    = $('#card_month :selected').val() - 1; 
  card_year     = $('#card_year :selected').val();
  expiry_date   = new Date(card_year, card_month);
  curr_month    = new Date().getMonth();
  curr_year     = new Date().getFullYear();
  curr_date     = new Date(curr_year, curr_month);

  if (expiry_date >= curr_date ) {
    return true;
  } else {
    return false;
  }
}

window.validate_terms = function() {
  if ($("#terms_of_service").is(':checked')) {
    return true;
  } else {
    return false;
  }
}

window.all_validations_pass = function() {
  if (validate_credit_card() == true && validate_cvc() == true && validate_card_name() == true && validate_card_zip() == true && validate_date() == true && validate_terms() == true) {
    return true;
  } else {
    return false;
  }
}

var add_final_error = function(message) {
  $('#final-error-list').append('<li>' + message + '</li>');
}

var on_blur = function(element) {
  $("#" + element).blur( function() {
    result = window["validate_" + element]();
    parentDiv = $("#" + element).parent();
    errorGlyph = '<span id="glyphicon-' + element + '" class="glyphicon glyphicon-remove form-control-feedback"></span>';
    successGlyph = '<span id="glyphicon-' + element + '" class="glyphicon glyphicon-ok form-control-feedback"></span>';
    parentDiv.removeClass('has-error').removeClass('has-feedback').addClass('has-feedback');
    $('#glyphicon-' + element).remove();

    if (result == false) {
      parentDiv.addClass('has-error');
      $("#" + element).after(errorGlyph);
    } else {
      $("#" + element).after(successGlyph);
    }
  });
}

var payment_fields = ["credit_card", "cvc", "card_name", "card_zip"];

// Validations on the form

for (var i = 0; i < payment_fields.length; i++ ) {
  on_blur(payment_fields[i]);
}


// Validations at the purchase page

$('#terms_of_service').click( function() {
  if ( all_validations_pass() == true ) {
    $('#purchase-submit').prop('disabled', false);
    $('#final-error-list').empty();
  } else {
    $('#purchase-submit').prop('disabled', true);
  }
});

$('#second_next').click( function() {
  $('#final-error-list').empty();
  $('#final-how-to').remove();

  if ( all_validations_pass() == true ) {
    $('#purchase-submit').prop('disabled', false);
  } else {
    $('#final-error-list').append('<p id="not_quite_ready">You have not quite completed the process</p>');
  }

  if ( validate_card_name() == false ) {
    add_final_error("No name has been entered.");
  }

  if ( validate_card_zip() == false ) {
    add_final_error("Your zip code is not valid.");
  }

  if (validate_credit_card() == false) {
    add_final_error("Your card number is not valid.");
  }

  if ( validate_date() == false ) {
    add_final_error("Your expiration date is not valid.");
  }

  if ( validate_cvc() == false ) {
    add_final_error("Your verification number is not valid.");
  }

});


// Progress Bar & Step by Step

  var $delay = 0;

  $('#step-one-indicator').addClass('highlighted');
  $('#step-two-status').addClass('inactive');
  $('#step-three-status').addClass('inactive');
  $('#payment-form').hide();
  $('#order-summary').hide();

  $('#first_next').click(function () {
    $('#step-one-status').addClass('inactive');
    $('#step-one-indicator').removeClass("highlighted").addClass('completed');
    $('#step-two-status').removeClass('inactive');
    $('#step-two-indicator').addClass('highlighted');
    $('#billing-information').slideToggle($delay);
    $('#payment-form').slideToggle($delay);
  });

  $('#second_next').click(function () {
    $('#step-two-status').addClass('inactive');
    $('#step-two-indicator').removeClass("highlighted").addClass('completed');
    $('#step-three-status').removeClass('inactive');
    $('#step-three-indicator').addClass('highlighted');
    $('#payment-form').slideToggle($delay);
    $('#order-summary').slideToggle($delay);
  });

  $('#second_back').click(function () {
    $('#step-two-status').addClass('inactive');
    $('#step-two-indicator').removeClass("highlighted");
    $('#step-one-status').removeClass('inactive');
    $('#step-one-indicator').removeClass("completed").addClass('highlighted');
    $('#payment-form').slideToggle($delay);
    $('#billing-information').slideToggle($delay);
  });

  $('#third_back').click(function () {
    $('#step-three-status').addClass('inactive');
    $('#step-three-indicator').removeClass("highlighted");
    $('#step-two-status').removeClass('inactive');
    $('#step-two-indicator').removeClass("completed").addClass('highlighted');
    $('#order-summary').slideToggle($delay);
    $('#payment-form').slideToggle($delay);
  });

});

