class Mocha::Expectation

  # Adds juicy syntax like this:
  #   something.expects(:call).during some_action
  # It will install the expectation and then run #some_action
  def during(_); end

end

