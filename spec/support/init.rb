def before_voting_started
  @controller.stubs(:before_voting? => true, :after_voting? => false, :during_voting? => false)
end
