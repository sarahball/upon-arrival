$(document).ready(function(){
  $('.dialog').dialog({
    autoOpen: false,
    height: 400,
    width: 350,
    modal: true,
    buttons: {
      "Update Card": function(){
        $(this).find('form')[0].submit();
      },
      Cancel: function() {
        $(this).dialog('close')
      }
    },
    close: function() {
      $(this).find('form')[0].reset();
    }
  });

  $('[data-type="dialog"]').on('click', function(){
    var dialogElm = $($(this).data('target'));
    dialogElm.dialog('open')
  });
});
