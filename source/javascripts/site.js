// This is where it all goes :)
//= require jquery
//= require jquery-ui
//=require jquery-ui/widgets/accordion
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