# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do 
    User.destroy_all
    Shift.destroy_all
    Organization.destroy_all

jane = User.create!(
    name: "Jane brown",
    email: 'janebrown@jb.com',
    password: 'janeb123'
)
john = User.create!(
    name: 'John Smith',
    email: 'johnsmith@js.com',
    password: 'johns123'
)

elle = User.create!(
    name: 'Elle Jones',
    email: 'ellejones@ellej.com',
    password: '123456'
)

bobs_burger = Organization.create!(
    name: "Bob's Burger",
    hourly_rate: 0.1e2
)

moes_tavern = Organization.create!(
    name: "Moe's Tavern",
    hourly_rate: 0.14e2
)

sallys_sandwiches = Organization.create!(
    name: "Sally's Sandwiches",
    hourly_rate: 0.11e2
)

shift1 = Shift.create!(
    user_id: jane.id,
    organization_id: bobs_burger.id,
    start: "2019-07-02 10:15:00",
    finish: "2019-07-02 13:15:00",
    break_length: 0
)
shift2 = Shift.create!(
    user_id: john.id,
    organization_id: bobs_burger.id,
    start: "2019-05-02 09:00:00",
    finish: "2019-05-02 13:00:00",
    break_length: 30
)

shift3 = Shift.create!(
    user_id: elle.id,
    organization_id: bobs_burger.id,
    start: "2019-01-31 11:00:00",
    finish: "2019-01-31 23:00:00",
    break_length: 60
)



end