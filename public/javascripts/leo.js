function disabled(e) { return $(e).hasClass('disabled'); }
function send(status) {
  var f = $("form.edit_registration");
  $('#registration_status').val(status);
  f.submit();
}

$(function() {
	$("a.button").click(function(e) {
	  if (disabled(this)) e.preventDefault();
	});

  $("a#confirm").click(function(e) {
    e.preventDefault();
    $('#deny_reason').val('');
    send('confirmed');
  });

	$("a#deny").click(function(e) {
    e.preventDefault();
    var reason = $("#registration_deny_reason").val();
    if (reason.trim().length == 0) {
      alert("Please enter the reason for denying.");
    } else {
      send('denied');
    }
	});
});