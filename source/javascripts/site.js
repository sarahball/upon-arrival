// This is where it all goes :)
//= require jquery
//= require jquery-ui
//=require jquery-ui/widgets/accordion
//=require jquery-ui/widgets/selectmenu
//= require jquery.matchHeight

$( function() {
  $( "#accordion" ).accordion({
  	collapsible: true,
  	active: false,
  	heightStyle: "content",
  	header: ".item-title"
  });
} );

$(function() {
	$('.item-title').matchHeight({
    byRow: false,
    property: 'height',
    target: null,
    remove: false
  });
});

$(function() {
  $("#wherefrom").selectmenu({
  })
});

$(function() {
  $("#wheregoing").selectmenu({
    change: function(event, data){ 
      if (data.item.value == "going1") { 
        $("body").css("background", "url(/images/bg-london.jpg) no-repeat center center fixed");
      }
      else if (data.item.value == "going2") {
        $("body").css("background", "url(/images/bg-chiangmai.jpg) no-repeat center center fixed");
      }
      else if (data.item.value == "going3") {
        $("body").css("background", "url(/images/bg-berlin.jpg) no-repeat center center fixed");
      }
      else if (data.item.value == "going4") {
        $("body").css("background", "url(/images/bg-lisbon.jpg) no-repeat center center fixed");
      }
    }
  })
});
