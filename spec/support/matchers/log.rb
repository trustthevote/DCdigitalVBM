Spec::Matchers.define :have_log_record do |type, options|
  match do |obj|
    deny_reason   = options[:deny_reason] || nil
    reviewer      = options[:reviewer]
    registration  = options[:registration]

    !obj.log_records.detect do |r|
      r.type == "LogRecord::#{type}" &&
        r.deny_reason == deny_reason &&
        (reviewer.nil? || r.reviewer == reviewer) &&
        (registration.nil? || r.registration == registration)
    end.nil?
  end
end

