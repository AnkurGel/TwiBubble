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

$(document).ready(function(){
  $("input[type=\"submit\"]").click(function(event){
    $("#error_explanation span").remove();
    if ($("#cloud_twitter_handle").val() == "")
      {

        $("#error_explanation").fadeOut();
        $("#error_explanation").append("<span>Please enter a twitter handle first..</span>");
        $("#error_explanation").fadeIn();
        $("input[type=\"text\"]").css('border-color', 'rgba(182, 168, 236, 0.8)' );
        event.preventDefault();
      }
    else
      {
        var x = true;
        if (!($("input#cloud_type_frequency").attr('checked')) && ($("input#cloud_tweets_count").val() > 40))
          {
            if (confirm("Process may be intensive while generating the cloud. We suggest taking less count for phrases. Proceed anyway?"))
              { }
            else
              {
                x = false;
              event.preventDefault();
              }
          }
        if (x){
        $(this).removeClass('btn-primary');
        $(this).addClass('btn-danger disabled');
        $(this).attr('value', 'Please Wait..');}
      }
  });
  $("a#flash_link").animate({letterSpacing:'2px'}
                            , 'slow').effect("highlight", {color: "yellow"} , 4000);
  $("input#cloud_twitter_handle").keydown(function(){
    $(this).attr('placeholder', '@AnkurGel');
  });
  $("input#cloud_twitter_handle").keyup(function(){$(this).attr('placeholder', 'Enter twitter handle...');});
});

$(function(){
  $("#slider-range-min").slider({
    range: 'min', value: 40, max: 1000, slide: function(event, ui){
      $("#cloud_tweets_count").val(ui.value);
    }
  });
  $("#cloud_tweets_count").val($("#slider-range-min").slider('value'));
});
var word_array = new Array();
var tweets = gon.tweets;
for(var i = 0; i < tweets.length; i++)
  {
    word_array.push({ text: tweets[i][0].toString() + "   ", weight: (tweets[i][1]) });
  }

$(function(){
  $("#TwiBubble").jQCloud(word_array);
});



