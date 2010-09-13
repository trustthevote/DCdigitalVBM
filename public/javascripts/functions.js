/* Declare a namespace for the site */
var Site = window.Site || {};

Site.EXPAND_HEADER_DURATION = 100;

function showTooLatePopup() { showPopup("#popup_tooLate"); }
function showTooEarlyPopup() { showPopup("#popup_tooEarly"); }

function showPopup(id) {
	$(id).show();
	$("#blanket").show();
	$('#blanket').height($(document.body).outerHeight());
}

var attestationSeen = false;
var ballotSeen = false;

function attestationLoaded() {
  attestationSeen = true;
  checkboxChanged(false);
}

function checkboxChanged(event) {
	var confirm = $("#confirm-checkbox");
	var affirm = $("#affirm-checkbox");
	var ad = $("#attestation-pdf-disabled");
	var a = $("#attestation-pdf");
	var btn = $("#confirm-continue");

	if (affirm.attr("checked") && confirm.attr("checked")) {
		ad.hide();
		a.show();
		if (digital || attestationSeen) enableBtn(btn);
	} else {
		ad.show();
		a.hide();
		disableBtn(btn);
	}
}

function ballotLoaded() {
  ballotSeen = true;
  updateComplete();
}

function updateComplete() {
  var btn = $("#complete-continue");
  if (ballotSeen) {
    enableBtn(btn);
  } else {
    disableBtn(btn);
  }
}

function disableBtn(btn) { if (!btn.hasClass("disabled")) btn.addClass("disabled").click(function(e) { e.preventDefault(); }); }
function enableBtn(btn) { if (btn.hasClass("disabled")) btn.removeClass("disabled").unbind("click"); }

function showAllHeadersClicked(event) {
	$(".expandcontent").show(Site.EXPAND_HEADER_DURATION);
	$(".expandheader").addClass("expanded");
}

function showHideHeadersClicked(event) {
	var allExpanded = true;
	$(".expandheader").each(function(){
		if (!$(this).hasClass("expanded")) allExpanded = false;
	});
	
	if (allExpanded == true) {
		$(".expandcontent").hide(Site.EXPAND_HEADER_DURATION);
		$(".expandheader").removeClass("expanded");
	} else {
		$(".expandcontent").show(Site.EXPAND_HEADER_DURATION);
		$(".expandheader").addClass("expanded");
	}
}

function expandheaderClicked(event){
	var target = $(event.target);
	
	target.next('.expandcontent').slideToggle(Site.EXPAND_HEADER_DURATION);
	target.toggleClass("expanded");
}

$(function() {
	$("input[placeholder]").textPlaceholder();

	$(".expandheader").click(expandheaderClicked);
	
	$(".show-all-button").click(showHideHeadersClicked);

	$(".popup .close-button").click(function(i){
		$("#popup_tooLate").hide();
		$("#popup_tooEarly").hide();
		$("#blanket").hide();
	});

	showTooEarlyPopup();
	
	$("#confirm-checkbox").change(checkboxChanged);
	$("#affirm-checkbox").change(checkboxChanged);

	$("#attestation-pdf").click(attestationLoaded);
  var btnCC = $("#confirm-continue");
  if (btnCC) checkboxChanged(null);
	
  $("#ballot-pdf").click(ballotLoaded);
	var btnRC = $("#complete-continue");
	if (btnRC) updateComplete();

  $("#pdf").change(function() {
    var btn = $("#return-continue");
    if (this.value != '') enableBtn(btn); else disableBtn(btn);
  });
  disableBtn($("#return-continue"));
	
	/* Disable links to home page from support pages (So user is unable to have two instances of ballots at once) */
	$(".support-pages>header nav li:first-child a").attr('href', "");
	$(".support-pages #logo").attr('href', "");
});


$(window).bind("load", function() {
});
