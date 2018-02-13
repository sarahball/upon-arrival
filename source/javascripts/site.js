// This is where it all goes :)
//= require jquery
//= require jquery-ui/widgets/selectmenu
//= require jquery-ui/widgets/tabs
//= require jquery.matchHeight
//= require postload

$( function() {
  $("#tabs li a").click(function (e) {
    $(this).closest('#tabs').addClass('menu-open');
    $('.menu-open').find('.ui-tabs-anchor').addClass('tabs-top-a');
    $('.menu-open').find('.ui-tabs-nav').addClass('tabs-top-ul');
  });
} );

$( function() {
    $( "#tabs" ).tabs({
      collapsible: true,
      active: false
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

function homepageSelectRandomBackground(){
  if($("#wheregoing").length == 0) {
    return;
  }

  // Pick a random city from the <options>, then make that the background.
  var potentialCities = $("select#wheregoing option:not([value=''])");
  var randomNumber = Math.floor(Math.random() * potentialCities.length);
  var randomCity = potentialCities.eq(randomNumber);
  $('body').attr('class', 'locations locations-' + randomCity.val());
}

$(function() {

  homepageSelectRandomBackground();

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

