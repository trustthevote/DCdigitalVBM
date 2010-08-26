ActionController::Routing::Routes.draw do |map|
  map.with_options :controller => "pages" do |o|
    o.front     '/', :action => "front"
    o.overview  '/overview/:voting_type', :action => "overview", :requirements => { :voting_type => /(physical|digital)/ }
    o.connect   '/overview',  :action => "overview"
    o.check_in  '/check_in',  :action => "check_in"
    o.confirm   '/confirm',   :action => "confirm"
    o.complete  '/complete',  :action => "complete"
    o.return    '/return',    :action => "return"
  end
end
