$(document).ready(function () {

	var btn = $('#checkout_btn');

	btn.click( function() {
		btn.text('Building order...').removeClass('btn-primary').addClass('btn-processing');
		btn.click( function(e) {
			e.preventDefault();
		});
	});

});