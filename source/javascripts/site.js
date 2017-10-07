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
  });
  
  $("#wheregoing").selectmenu({
    change: function(event, data){ 
      if (data.item.value == "going1") { 
        document.body.classList.add("locations-london");
      }
      else if (data.item.value == "going2") {
        document.body.classList.add("locations-chiangmai");
      }
      else if (data.item.value == "going3") {
        document.body.classList.add("locations-berlin");
      }
      else if (data.item.value == "going4") {
       document.body.classList.add("locations-lisbon");
      }
      else if (data.item.value == "going5") {
       document.body.classList.add("locations-newyorkcity");
      }
      else if (data.item.value == "going6") {
       document.body.classList.add("locations-barcelona");
      }
      else if (data.item.value == "going7") {
       document.body.classList.add("locations-bangkok");
      }
      else if (data.item.value == "going8") {
       document.body.classList.add("locations-buenosaires");
      }
      else if (data.item.value == "going9") {
       document.body.classList.add("locations-amsterdam");
      }
      else if (data.item.value == "going10") {
       document.body.classList.add("locations-budapest");
      }
    }
  })

  $( ".ui-selectmenu-text" ).before( "<span class='locations-icon'></span>" );
});

