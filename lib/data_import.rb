class DataImport
  def run(address_filename, reg_filename)
    addresses = read_addresses(address_filename)
    import_registrations(reg_filename, addresses)
  end
  
  private
  
  def read_addresses(address_filename)
    addresses = {}

    puts " - Loading addresses"
    first = true
    FasterCSV.foreach(address_filename) do |row|
      if first
        first = false
        next
      end
      
      address_id, house_num, house_frac, st_pre_dir, st_name, st_type, apt_lot, post_dir, city, state, zip = *row
      addresses[address_id.to_i] = {
        :address => "#{house_frac} #{st_name.capitalize} #{st_type.capitalize}, #{apt_lot}".strip,
        :city    => city.strip,
        :state   => state.strip,
        :zip     => zip.strip }
    end
    
    puts "   Loaded #{addresses.count} addresses"
    
    addresses
  end
  
  def import_registrations(reg_filename, addresses)
    precinct = split = nil

    puts " - Loading registration data"
    first = true
    FasterCSV.foreach(reg_filename) do |row|
      if first
        first = false
        next
      end
      
      voterid, pin_hash, lastname, firstname, middlename, suffix, address_id, status_id, party_id, precinct_name, ward, smd = *row
      
      if precinct.nil? || precinct.name != precinct_name
        precinct = Precinct.find_or_create_by_name(precinct_name)
        split = nil
      end
      
      split_name = "#{precinct_name}_#{ward}_#{smd}"
      if split.nil? || split.name != split_name
        split = PrecinctSplit.find_or_create_by_name(:name => split_name, :precinct_id => precinct.id)
      end
      
      address = addresses[address_id.to_i]
      
      r = split.registrations.create(
        :name        => [ firstname, middlename, lastname, suffix ].reject { |i| i.blank? }.join(" "),
        :pin         => pin_hash, # TODO change to :pin_hash
        :voter_id    => voterid,
        :address     => address[:address],
        :city        => address[:city],
        :state       => address[:state],
        :zip         => address[:zip],
        :attestation => nil)
      
      puts "#{r.name.ljust(30, ' ')} #{pin_hash} #{voterid} #{address[:zip]}"
    end
  end
end
