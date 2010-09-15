ActionController::Routing::Routes.draw do |map|
  map.with_options :controller => "pages" do |o|
    o.front       '/', :action => "front"
    o.overview    '/overview/:voting_type', :action => "overview", :requirements => { :voting_type => /(physical|digital)/ }
    o.connect     '/overview',        :action => "overview"
    o.check_in    '/check_in',        :action => "check_in"
    o.confirm     '/confirm',         :action => "confirm"
    o.attestation '/attestation.pdf', :action => "attestation", :format => "pdf"
    o.complete    '/complete',        :action => "complete"
    o.return      '/return',          :action => "return"
    o.thanks      '/thanks',          :action => "thanks"
    
    o.about       '/about',           :action => "about"
    o.contact     '/contact',         :action => "contact"
  end

  map.with_options :controller => "help" do |o|
    o.help      '/help'
    o.help_page '/help/:section/:page', :action => "show"
    o.security  '/security',  :action => "show", :section => "security", :page => "index"
  end
end
