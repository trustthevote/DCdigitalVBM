def before_voting_started
  @controller.stubs(:before_voting? => true, :after_voting? => false, :during_voting? => false)
end

def login_as(u = Factory(:user))
  @controller.stubs(:current_user).returns(u)
end
alias :login :login_as