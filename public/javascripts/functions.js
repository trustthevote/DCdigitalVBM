/*
Version: OSDV Public License 1.2
The contents of this file are subject to the OSDV Public License
Version 1.2 (the "License"); you may not use this file except in
compliance with the License. You may obtain a copy of the License at
http://www.osdv.org/license/
Software distributed under the License is distributed on an "AS IS"
basis, WITHOUT WARRANTY OF ANY KIND, either express or implied.
See the License for the specific language governing rights and limitations
under the License.

The Original Code is:
	TTV UOCAVA Ballot Portal.
The Initial Developer of the Original Code is:
	Open Source Digital Voting Foundation.
Portions created by Open Source Digital Voting Foundation are Copyright (C) 2010.
All Rights Reserved.

Contributors: Paul Stenbjorn, Aleksey Gureiev, Robin Bahr,
Thomas Gaskin, Sean Durham, John Sebes.
*/

/* Declare a namespace for the site */
var Site = window.Site || {};

Site.EXPAND_HEADER_DURATION = 100;

function showPopup(id) {
	$(id).fadeIn(1000);
	$("#blanket").show().height($(document.body).outerHeight());
}

var attestationSeen = false;
var ballotSeen = false;

function attestationLoaded() {
  attestationSeen = true;
  checkboxChanged(false);
}

function checkboxChanged(event) {
	var conf = $("#confirm-checkbox");
	var affirm = $("#affirm-checkbox");
	var ad = $("#attestation-pdf-disabled");
	var a = $("#attestation-pdf");
	var btn = $("#confirm-continue");

	if (affirm.attr("checked") && conf.attr("checked")) {
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
		$("#popup").hide();
		$("#blanket").hide();
	});

  showPopup("#popup");
	
	$("#confirm-checkbox").click(checkboxChanged);
	$("#affirm-checkbox").click(checkboxChanged);

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
