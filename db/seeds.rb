# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Task.create(name: 'task5', content: 'Something', status: "in progress", priority: 2, limit_date: Date.today)

500.times do
  Task.create(name: 'task1', content: 'Something', status: "in progress", priority: 2, limit_date: Date.today)
end

50.times do
  Task.create(name: 'Task2', content: 'Great things',
     status: "unstarted", priority: 2, limit_date: Date.today)
end
