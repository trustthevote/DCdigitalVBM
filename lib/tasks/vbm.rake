namespace :vbm do
  desc "Generate sample seed records for db/fixtures"
  task :generate_test_seeds => :environment do
    SeedGenerator.new.run
  end
  
  desc "Display stats and the activity log"
  task :stats => :environment do
    Stats.new.run
  end
  
  namespace :voting_state do
    desc "Switches the voting into the 'before' state"
    task :before => :environment do
      VotingState.switch_to 'before'
    end

    desc "Switches the voting into the 'during' state"
    task :during => :environment  do
      VotingState.switch_to 'during'
    end

    desc "Switches the voting into the 'after' state"
    task :after => :environment  do
      VotingState.switch_to 'after'
    end
  end
end
