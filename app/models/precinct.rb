class Precinct < ActiveRecord::Base

  has_many :splits, :class_name => "PrecinctSplit", :dependent => :destroy

end
