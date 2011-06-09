$(document).ready(function(){
  $("#flash").slideDown("slow");
  $("#flash .dismiss a").click(function(e){
    $("#flash").slideUp("slow");
    e.stopPropogation();
  });
  if($("form .date").length){
    $("form .date").datepicker({dateFormat: "d MM yy"});
  }
  //$("form .date").datepicker("option","dateFormat","d MM y");
  $("#accordion").tabs("#accordion div.pane", {tabs: 'h2', effect: 'slide', initialIndex: null});
});
