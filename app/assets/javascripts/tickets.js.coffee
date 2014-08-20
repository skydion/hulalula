# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


window.resize = ->
  m = $("#main")
  mw = m.outerWidth(true)
  mh = m.outerHeight(true)
  console.log("MW: " + mw + ",  MH: " + mh)

  d1 = $(".d1")
  d1.css.width(w/2);

  r = $(".row")
  rw = r.width()
  rh = r.height()

  console.log("RW: " + rw + ",  RH: " + rh)
