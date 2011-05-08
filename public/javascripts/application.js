$(document).ready(function(){
  $("#flash").slideDown("slow");
  $("#flash .dismiss a").click(function(e){
    $("#flash").slideUp("slow");
    e.stopPropogation();
  });
});
