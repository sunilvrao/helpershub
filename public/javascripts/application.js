$(document).ready(function(){
  $("#flash").slideDown("slow");
  $("#flash .dismiss a").click(function(e){
    $("#flash").slideUp("slow");
    return false;
  });
  if($("form .date").length){
    $("form .date").datepicker({dateFormat: "d MM yy"});
  }
  //$("form .date").datepicker("option","dateFormat","d MM y");
  $("#accordion").tabs("#accordion div.pane", {tabs: 'h2', effect: 'slide', initialIndex: null});

  $('form#new_contact').submit(function(){
    var valid = true;
    $(this).find('.required :input').filter(':visible').each(function(){
      var val = $(this).val(), err = false;
      if(!$.trim(val)){
        $(this).addClass('error');
        valid = false;
      } else {
        $(this).removeClass('error');
      }
    });
    if(!valid){
      return false;
    }
  });

  $('#tweets').getTwitter({
    userName: "jquery",
    numTweets: 5,
    loaderText: "loading tweets...",
    slideIn: true,
    showProfileLink: true,
    showHeading: false
  });

  
});
