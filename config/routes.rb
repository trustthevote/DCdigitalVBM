# Version: OSDV Public License 1.2
# The contents of this file are subject to the OSDV Public License
# Version 1.2 (the "License"); you may not use this file except in
# compliance with the License. You may obtain a copy of the License at
# http://www.osdv.org/license/
# Software distributed under the License is distributed on an "AS IS"
# basis, WITHOUT WARRANTY OF ANY KIND, either express or implied.
# See the License for the specific language governing rights and limitations
# under the License.
# 
# The Original Code is:
# 	TTV UOCAVA Ballot Portal.
# The Initial Developer of the Original Code is:
# 	Open Source Digital Voting Foundation.
# Portions created by Open Source Digital Voting Foundation are Copyright (C) 2010.
# All Rights Reserved.
# 
# Contributors: Paul Stenbjorn, Aleksey Gureiev, Robin Bahr,
# Thomas Gaskin, Sean Durham, John Sebes.

ActionController::Routing::Routes.draw do |map|
  map.subdomain 'leo' do |c|
    c.with_options :controller => 'user_sessions', :name_prefix => '' do |s|
      s.connect     '/login',   :action => 'create', :conditions => { :method => :post }
      s.login       '/login',   :action => 'new'
      s.logout      '/logout',  :action => 'destroy'
    end

    c.with_options :controller => "pages" do |p|
      p.instructions '/instructions', :action => 'instructions'
    end

    c.root        :controller => 'voters', :action => 'show'
    c.resources   :voters, :only => [ :index, :show, :update ]    
    c.attestation '/voter/:id/attestation.pdf', :controller => 'voters', :action => 'attestation', :format => 'pdf'
    c.review      '/voters/review', :controller => 'voters', :action => 'show'
  end

  map.with_options :controller => "pages" do |o|
    o.front         '/', :action => "front"
    o.overview      '/overview/:voting_type', :action => "overview", :requirements => { :voting_type => /(physical|digital)/ }
    o.connect       '/overview',        :action => "overview"
    o.check_in      '/check_in',        :action => "check_in"
    o.confirm       '/confirm',         :action => "confirm"
    o.attestation   '/attestation.pdf', :action => "attestation", :format => "pdf"
    o.ballot        '/ballot.pdf',      :action => "ballot", :format => "pdf"
    o.complete      '/complete',        :action => "complete"
    o.return        '/return',          :action => "return"
    o.thanks        '/thanks',          :action => "thanks"
    
    o.about         '/about',           :action => "about"
    o.contact       '/contact',         :action => "contact"
  end

  map.with_options :controller => "help" do |o|
    o.help          '/help'
    o.help_page     '/help/:section/:page', :action => "show"
    o.security      '/security',  :action => "show", :section => "security", :page => "index"
  end
end
