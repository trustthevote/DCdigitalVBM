class DataImport
  
  def run(voter_csv_path, ballots_zip_path)
    check_files(voter_csv_path, ballots_zip_path)
    
    import_ballots(ballots_zip_path)
    import_voters(voter_csv_path)
  end
  
  private
  
  def convert_value(val)
    val = val.to_s.strip
    val.blank? || /^null$/i =~ val ? nil : val
  end
  
  # Imports voters from CSV
  def import_voters(voter_csv_path)
    log "Importing voters"

    splits_cache = {}
    imported = 0
    
    FasterCSV.foreach(voter_csv_path, :col_sep => "\t", :headers => :first_row, :skip_blanks => true) do |row|
      # Split details
      pname   = row['SPLIT'].strip.split(' ').first.strip
      anc     = (row['SMD'].strip)[0, 2]
      smd     = (row['SMD'].strip)[2, 2]
      
      # Find split for this voter
      split_name = make_split_name(pname, smd, anc)
      split = splits_cache[split_name]
      unless split
        split = PrecinctSplit.find_by_name(split_name)
        splits_cache[split_name] = split
      end
      
      raise "Missing ballot for split: #{split_name}. Check your ballots archive." unless split
      
      split.registrations.create!(
        :voter_id     => convert_value(row['VOTER_ID']),
        :pin_hash     => convert_value(row['PIN_HASH']),
        :first_name   => convert_value(row['FIRSTNAME']),
        :middle_name  => convert_value(row['MIDDLE']),
        :last_name    => convert_value(row['LASTNAME']),
        :address      => convert_value(row['MAILINGADDRESS']),
        :ssn4         => convert_value((row['SSN'].strip)[-4, 4]), # Grab last four digits of SSN only
        :zip          => convert_value(row['ZIP']))

      imported += 1
    end
    
    log "  - Imported #{imported} voters"
  end
  
  # Imports ballot files from ZIP
  def import_ballots(ballots_zip_path)
    log "Importing ballots"
    
    path = unzip_to_temp_dir(ballots_zip_path)
    info = get_ballot_info(path)
    
    update_precincts(info)
  ensure
    log "  - Removing: #{path}"
    FileUtils.rmtree(path)
  end

  def update_precincts(ballot_info)
    log "  - Removing old precincts, splits and registrations"
    Precinct.destroy_all
    
    log "  - Loading ballots for splits:"

    ballot_info.each do |bi|
      split_name  = make_split_name(bi[:precinct], bi[:smd], bi[:anc])
      log "    - #{split_name}"
      
      # Create pricinct & split
      precinct    = Precinct.find_or_create_by_name(bi[:precinct])
      split       = PrecinctSplit.find_or_create_by_name(:name => split_name, :precinct_id => precinct.id)
      
      # Replace ballot
      split.create_ballot_style(:pdf => File.open(bi[:path], 'rb'))
    end
  end
  
  def get_ballot_info(path)
    Dir.glob(File.join(path, '*.pdf')).map do |filepath|
      keys = filepath.scan(/P(.*)-SMD-(.*)-ANC-(.*)\.pdf/).flatten
      
      raise "Invalid file name is detected: #{filename}" unless keys.size == 3
      
      p, smd, anc = keys
      
      { :path     => filepath,
        :precinct => p,
        :smd      => smd,
        :anc      => anc }
    end
  end
  
  def unzip_to_temp_dir(ballots_zip_path)
    path = make_temp_dir

    log "  - Unarchiving ballots to #{path}"
    system('unzip', '-j', '-q', ballots_zip_path, '*.pdf', '-x', '**/.*.pdf', '-d', path)

    path
  end
  
  def make_temp_dir
    FileUtils.mkdir(path = "#{Dir::tmpdir}/vbm-import-#{Time.now.to_i}")
    path
  end
  
  # Verifies that files exist and of a required type
  def check_files(voter_csv_path, ballots_zip_path)
    raise "Voter CSV file was not specified"    if voter_csv_path.blank?
    raise "Ballots ZIP file was not specified"  if ballots_zip_path.blank?
    raise "Voter CSV file doesn't exist"        unless File.exists?(voter_csv_path)
    raise "Ballots ZIP file doesn't exist"      unless File.exists?(ballots_zip_path)    
  end
  
  def make_split_name(p, smd, anc)
    "P%s-SMD-%s-ANC-%s" % [ p, smd, anc ]
  end
  
  def log(msg)
    puts msg
  end
end