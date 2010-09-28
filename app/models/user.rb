class User < ActiveRecord::Base
  acts_as_authentic

  has_many :status_changes, :dependent => :nullify

end
