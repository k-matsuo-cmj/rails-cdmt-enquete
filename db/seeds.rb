# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# admin
User.new(
  email: "admin@example.com", password: "password", confirmed_at: Date.current, admin:true
).build_profile(name: "管理者").save

# manager / team
managers = []
teams = []
(0..5).each do |i|
  managers << User.new(
    email: "m#{i}@example.com", password: "password", confirmed_at: Date.current)
  managers[i].build_profile(
    name: "マネージャー#{i}", grade: "G5", status: "Q3-MAX", emp_no: i + 10)
  managers[i].save
  teams << Team.create(
    name: "チーム#{i}", manager: managers[i]
  )
end

# team 0 (managers)
teams[0].team_users.build(managers.map{ |m| {user: m} })
teams[0].save

# team 6 add
teams << Team.create(name: "新チーム", manager: managers[0])

# team 1-6
(1..6).each do |i|
  members = []
  rand(3..9).times do |j|
    members << User.new(
      email: "u#{i}_#{j}@example.com", password: "password", confirmed_at: Date.current)
    members[j].build_profile(
      name: "メンバー#{i}-#{j}", grade: "G#{rand(1..4)}", status: "MID-Q3", emp_no: i * 100 + j)
    members[j].save

    teams[i].team_users.build(user: members[j])
    teams[i].save
  end
end