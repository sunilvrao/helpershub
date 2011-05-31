$(document).ready(function(){
  $("#flash").slideDown("slow");
  $("#flash .dismiss a").click(function(e){
    $("#flash").slideUp("slow");
    e.stopPropogation();
  });
  //$("form .date").datepicker({dateFormat: "d MM yy"});
  //$("form .date").datepicker("option","dateFormat","d MM y");
});
