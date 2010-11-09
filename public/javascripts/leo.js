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
    if ($.trim(reason.trim).length == 0) {
      alert("Please enter the reason for denying.");
    } else {
      send('denied');
    }
	});
	
	$("a#skip").click(function(e) {
	  e.preventDefault();
	  send('');
	});
});