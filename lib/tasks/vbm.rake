namespace :vbm do
  desc "Generate sample seed records for db/fixtures"
  task :generate_test_seeds => :environment do
    SeedGenerator.new.run
  end
  
  desc "Display stats and the activity log"
  task :stats => :environment do
    Stats.new.run
  end
end
