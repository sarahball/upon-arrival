// This is where it all goes :)
//= require jquery
//= require jquery-ui
//= require jquery-ui/widgets/accordion
//= require jquery-ui/widgets/selectmenu
//= require jquery.matchHeight
//= require postload

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

  // Restore previous selections - TODO: Renable when we've decided on how this should work.
  if( false && $("#wheregoing").length > 0 &&  typeof(localStorage["wherefrom"]) != 'undefined' && typeof(localStorage["wheregoing"]) != 'undefined'){
    $("select#wherefrom option").each(function() { this.selected = (this.value == localStorage["wherefrom"]); });
    $("select#wheregoing option").each(function() { this.selected = (this.value == localStorage["wheregoing"]); });

    // Set the background image to be the same
    var labelClassName = $("select#wheregoing option:selected").val();
    $('body').attr('class', 'locations locations-'+labelClassName);
  }

  $("#wherefrom").selectmenu({});
  
  $("#wheregoing").selectmenu({
    change: function(event, data){ 
      var labelClassName = data.item.value;
      $('body').attr('class', 'locations locations-'+labelClassName);
    }
  });

  $( ".ui-selectmenu-text" ).before( "<span class='locations-icon'></span>" );

  $("#locations-form").on('submit', function(e){
    e.preventDefault();

    // Don't redirect when the hasn't had both options selected.
    if( $("#wherefrom").val() == "" || $("#wheregoing").val() == "" ){ return; }

    // Save the options selected for future use
    localStorage["wherefrom"] = $("#wherefrom").val();
    localStorage["wheregoing"] = $("#wheregoing").val();

    // Redirect the user to their information page
    var newLocation = $(this).data('redirect-to');
    newLocation = newLocation.replace(/#{wherefrom}/g, $("#wherefrom").val()).replace(/#{wheregoing}/g, $("#wheregoing").val());

    window.location.href = newLocation;
  });
});

