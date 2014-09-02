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

/*function getScrollBarWidth () {
 var inner = document.createElement('p');
 inner.style.width = "100%";
 inner.style.height = "200px";

 var outer = document.createElement('div');
 outer.style.position = "absolute";
 outer.style.top = "0px";
 outer.style.left = "0px";
 outer.style.visibility = "hidden";
 outer.style.width = "200px";
 outer.style.height = "150px";
 outer.style.overflow = "hidden";
 outer.appendChild (inner);

 document.body.appendChild (outer);
 var w1 = inner.offsetWidth;
 outer.style.overflow = 'scroll';
 var w2 = inner.offsetWidth;
 if (w1 == w2) w2 = outer.clientWidth;

 document.body.removeChild (outer);

 return (w1 - w2);
 }*/

// for example
/*        var expandData = $(this).attr('data-expand');

 if (expandData === 'true') {
 $(this).attr('data-expand', 'false');
 }
 else if (expandData === 'false') {
 $(this).attr('data-expand', 'true');
 }*/

function setMainHeight() {
    // 88 = header + padding*2 (68+10*2)
    // 60 = footer + padding*2 + border (30+10*2+10)
    var wh = $(window).height();
    //console.log("windows.height: ", wh);

    var m = $("#main");
    m.height(wh - 88 - 60);

    // 250 = comment header
    $(".comments_area").height(m.height() - 250);
}

$(document).ready(function () {
    setMainHeight();
});

$(window).resize(function () {
    setMainHeight();
});
