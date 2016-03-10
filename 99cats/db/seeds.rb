# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

9.times do
  c = Cat.create!(
  name: Faker::Name.name,
  birth_date: Faker::Time.between(14.years.ago, Time.now, :all),
  sex: ["M","F"].sample,
  color: 0xFFFFFF
  )

  CatRentalRequest.create!(
    start_date: Faker::Time.between(14.days.ago,7.days.ago),
    end_date: Faker::Time.between(6.days.ago,Time.now),
    cat_id: c.id 
  )
end
