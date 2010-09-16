class Stats
  
  def run
    total      = Registration.count
    inactive   = Registration.inactive.count
    unfinished = Registration.unfinished.count
    physical   = FlowCompletion.physical.count
    digital    = FlowCompletion.digital.count

    [ [ "Total number of voters", total ],
      [ "Inactive", "#{inactive} (#{percent(inactive, total)})" ],
      [ "Used the system but not finished", "#{unfinished} (#{percent(unfinished, total)})" ],
      [ "Used the system and finished the physical flow", "#{physical} (#{percent(physical, total)})" ],
      [ "Used the system and finished the digital flow", "#{digital} (#{percent(digital, total)})" ] ].each do |f|
      puts "%-50s: %s" % f
    end
    
    log
  end
  
  private
  
  def percent(n, t)
    "%6.2f%%" % (100.0 * n / t)
  end
  
  def log
    checked_in = Registration.checked_in.all(:select => "checked_in_at as dte, name, voter_id", :order => "dte asc")
    completed  = FlowCompletion.all(:select => "flow_completions.created_at as dte, voting_type, name, voter_id", :joins => :registration, :order => "dte asc")
    records    = [ checked_in, completed ].flatten.compact.sort_by { |r| r.dte }

    puts
    puts "Activity log:"
    puts
    
    records.each do |r|
      dte, name, voter_id, voting_type = r.dte, r.name, r.voter_id, r.attributes["voting_type"]
      type = voting_type.nil? ? "Checked in" : "Completed #{voting_type} flow"

      puts "%s - %-23s - %s %s" % [ dte, type, voter_id, name ]
    end
  end
  
end