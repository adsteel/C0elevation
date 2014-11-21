// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require responsiveslides
//= require_tree .


//  Tests the Javascript and Jquery simultaneously

function ready() {
  console.log("application.js fired");
	Turbolinks.enableTransitionCache();
	
	// bootsuite tracking code
	var _bsc = _bsc || {};
	(function() {
	    var bs = document.createElement('script');
	    bs.type = 'text/javascript';
	    bs.async = true;
	    bs.src = ('https:' == document.location.protocol ? 'https' : 'http') + '://d2so4705rl485y.cloudfront.net/widgets/tracker/tracker.js';
	    var s = document.getElementsByTagName('script')[0];
	    s.parentNode.insertBefore(bs, s);
	})();
}

$(document).ready(ready);
