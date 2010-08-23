Factory.sequence(:pin) { |i| i.to_s.rjust(4, '0') }

Factory.define :registration do |f|
  f.name { Faker::Name.name }
  f.pin  { Factory.next(:pin) }
end
