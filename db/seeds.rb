# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do
  Task.create(name: "task", content: "some content", status: "in progress", priority: 2, limit_date: Date.today)
end

30.times do
  Task.create(name: "task1", content: "some content", status: "unstarted", priority: 1, limit_date: Date.today)
end

User.create(name: "loren", email: 'lorensemevo@gmail.com', password: 'hello1234', password_confirmation: 'hello1234', admin: true)
