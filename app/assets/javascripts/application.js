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
//= require jquery_ujs
//= require turbolinks
//= require_tree .

/*
$(document).ready(function() {
    // Just for demonstration purposes, change the contents/active state using jQuery
    $("#menu ul li a").click(function () {
        $("#menu ul li a").each(function () {
            $(this).removeClass("active");
        });

        $(this).addClass("active");
    });
});
*/

/*$(document).ready(function() {
    var m = $("#main");
    var mw = m.width();

    $(".d1").width( mw/2 );
    $(".d2").width( mw/2 );
    $(".d3").width( mw/2 );
    $(".d4").width( mw/2 );
});
 */

$(window).resize( function() {
    var m = $("#main");

    var mw = m.width();
    var mh = m.height();
    //console.log("MW: " + mw + ",  MH: " + mh);

    $(".d1").width( mw/2 );
    $(".d2").width( mw/2 );
    $(".d3").width( mw/2 );
    $(".d4").width( mw/2 );

    $("footer#page_footer").bottom( mh );
});
