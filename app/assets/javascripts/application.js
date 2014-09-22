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
//= require jquery-ui
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function setMainHeight() {
    // 88 = header + padding*2 (68+10*2)
    var pheader = $("#page_header");
    var ph = pheader.height() +
        parseInt(pheader.css('padding-top')) +
        parseInt(pheader.css('padding-bottom'));
    //console.log('ph: ' + ph + 'px');

    // 60 = footer + padding*2 + border (30+10*2+10)
    var pfooter = $("#page_footer");
    var pf = pfooter.height() +
        parseInt(pfooter.css('padding-top')) +
        parseInt(pfooter.css('padding-bottom')) +
        parseInt(pfooter.css('border-bottom-width'));
    //console.log('pf: ' + pf + 'px');

    var wh = $(window).height();

    var m = $("#main");
    m.height(wh - ph - pf);
    m.css('top', ph+'px');

    // 250 = comment header
    $(".comments_area").height(m.height() - 250);
}

$(document).ready(function () {
    setMainHeight();
});

$(window).resize(function () {
    setMainHeight();
});
