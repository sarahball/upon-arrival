$(document).ready(function(){
  $('.dialog').dialog({
    autoOpen: false,
    width: 450,
    modal: true
  });

  $('[data-type="dialog"]').on('click', function(){
    var dialogElm = $($(this).data('target'));
    dialogElm.dialog('open')
  });
});
