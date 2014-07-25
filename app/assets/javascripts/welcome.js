/*
 * Author:      Marco Kuiper (http://www.marcofolio.net/)
 */

// google = google.load("jquery");
// google.setOnLoadCallback(SwitchTab());

$(document).ready(function() {
    // Just for demonstration purposes, change the contents/active state using jQuery
    $("#menu ul li a").click(function () {
        $("#menu ul li a").each(function () {
            $(this).removeClass("active");
        });

        $(this).addClass("active");

        $("h3").html($(this).html());
    });
});
