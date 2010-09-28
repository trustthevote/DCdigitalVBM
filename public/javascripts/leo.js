function disabled(e) { return $(e).hasClass('disabled'); }
function send(url, args, method) {
  var f = $("<form></form>").attr('method', 'POST').attr('action', url);

  args['_method'] = method;
  args['authenticity_token'] = window._token;
  
  for (var name in args) f.append($("<input></input>").attr('type', 'hidden').attr('name', name).attr('value', args[name]));
  
  f.submit();
}

$(function() {
	$("a.button").click(function(e) {
	  if (disabled(this)) e.preventDefault();
	  return false;
	});

  $("#change_status").click(function(e) {
	  $(this).hide();
	  $("#review_controls").show();
	});
	
	$("a#confirm").click(function(e) {
    e.preventDefault();
    if (disabled(this)) return;

    send(this.href, { 'registration[status]': 'confirmed' }, 'put');
	});
	
	$("a#deny").click(function(e) {
    e.preventDefault();
	  if (disabled(this)) return;
	  
	  $(this).hide();
	  $("#deny_reason").show();
	});
});