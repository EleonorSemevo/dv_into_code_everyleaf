# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(name: "eleonor", email: 'eleonor@gmail.com', password: 'hello1234', password_confirmation: 'hello1234')
User.create(name: "admin", email: 'admin@gmail.com', password: 'admin123', password_confirmation: 'admin123', admin: true)

Task.create(name: 'task5', content: 'Something', status: "in progress", priority: 2, limit_date: Date.today,user_id: 1)

500.times do
  Task.create(name: 'task1', content: 'Something', status: "in progress", priority: 2, limit_date: Date.today, user_id: 2)
end

50.times do
  Task.create(name: 'Task2', content: 'Great things',
     status: "unstarted", priority: 2, limit_date: Date.today, user_id: 1)
end


  Tag.create(user_id: 1, name: 'article1')
  Tag.create(user_id: 1, name: 'article2')
  Tag.create(user_id: 1, name: 'article3')
  Tag.create(user_id: 2, name: 'article1')
  Tag.create(user_id: 2, name: 'article2')
  Tag.create(user_id: 2, name: 'article3')
