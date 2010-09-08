puts "Cleaning the database"
Precinct.destroy_all

puts "TODO: Enable gemcutter in gemfile back"

puts "Importing seed data"
path = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures'))

di = DataImport.new
di.run("#{path}/AddressID.csv", "#{path}/RegSchema.csv")
