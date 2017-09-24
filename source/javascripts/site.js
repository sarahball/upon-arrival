// This is where it all goes :)
//= require jquery
//= require jquery-ui

//=require jquery-ui/widgets/accordion

$( function() {
  $( "#accordion" ).accordion({
  	collapsible: true,
  	active: false,
  	heightStyle: "content"
  });
} );