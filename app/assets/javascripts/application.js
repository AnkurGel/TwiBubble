// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require jqcloud

// var word_array = [ $(".hidden").html()];
if (gon.hash)
  alert(gon.hash);


var word_array = [
  {text: "15", weight: 15},
  {text: "9", weight: 9, link: "http://jquery.com/"},
  {text: "6", weight: 6, html: {title: "I can haz any html attribute"}},
  {text: "7", weight: 7},
  {text: "5", weight: 5}
];

$(function(){
  $("#example").jQCloud(word_array);
});
