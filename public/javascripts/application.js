function disableLink(l) {
  l = $(l);
  l.addClass('disabled');
  l.click(function(e) { e.preventDefault(); });
}

function enableLink(l) {
  l = $(l);
  l.removeClass('disabled');
  l.unbind('click');
}

$(function() {
  $("img.tip[title]").tipTip();
});