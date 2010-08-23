ActionController::Routing::Routes.draw do |map|
  map.with_options :controller => "pages" do |o|
    o.front     '/', :action => "front"
    o.overview  '/overview/:voting_type', :action => "overview", :requirements => { :voting_type => /(physical|digital)/ }
    o.connect   '/overview', :action => "overview"
    o.confirm   '/confirm', :action => "confirm"
    o.check_in  '/check_in', :action => "check_in"
  end
end
