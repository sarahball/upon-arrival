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
      var labelClassName = data.item.label.toLowerCase().replace(' ', '');
      $('body').attr('class', 'locations locations-'+labelClassName);
    }
  })

  $( ".ui-selectmenu-text" ).before( "<span class='locations-icon'></span>" );
});

