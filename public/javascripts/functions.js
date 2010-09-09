/* Declare a namespace for the site */
var Site = window.Site || {};

Site.EXPAND_HEADER_DURATION = 100;

/* Create a closure to maintain scope of the '$'
   and remain compatible with other frameworks.  */
(function($) {
	
	//same as $(document).ready();
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
		
		/* Disable links to home page from support pages (So user is unable to have two instances of ballots at once) */
		$(".support-pages>header nav li:first-child a").attr('href', "");
		$(".support-pages #logo").attr('href', "");
	});


	$(window).bind("load", function() {
	});

})(jQuery);






function showTooLatePopup(){
	$("#popup_tooLate").show();
	$("#blanket").show();
/* 	$('#blanket').height(document.html.scrollHeight); */
	$('#blanket').height($(document.body).outerHeight());
}

function showTooEarlyPopup(){
	$("#popup_tooEarly").show();
	$("#blanket").show();
/* 	$('#blanket').height(document.html.scrollHeight); */
	$('#blanket').height($(document.body).outerHeight());
}



function checkboxChanged(event) {
	var $confirm = $("#confirm-checkbox");
	var $affirm = $("#affirm-checkbox");
	
	if($affirm.attr("checked") && $confirm.attr("checked")) {
		$("#attestation-pdf-disabled").hide();
		$("#attestation-pdf").show();
	} else {
		$("#attestation-pdf-disabled").show();
		$("#attestation-pdf").hide();
	}
}



function showAllHeadersClicked(event) {
	$(".expandcontent").show(Site.EXPAND_HEADER_DURATION);
	$(".expandheader").addClass("expanded");
}

function showHideHeadersClicked(event) {
	var allExpanded = true;
	$(".expandheader").each(function(){
		if (!$(this).hasClass("expanded")) {
			allExpanded = false;
		};
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
	var $target = $(event.target);
	
	$target.next('.expandcontent').slideToggle(Site.EXPAND_HEADER_DURATION);
	$target.toggleClass("expanded");
}
