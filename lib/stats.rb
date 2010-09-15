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
  end
  
  private
  
  def percent(n, t)
    "%6.2f%%" % (100.0 * n / t)
  end
  
end