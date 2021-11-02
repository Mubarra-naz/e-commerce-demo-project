# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: 'admin@projectname.com', firstname: 'Admin', lastname: 'Admin', username: 'AdminUser', password: 'Password123!@#', password_confirmation: 'Password123!@#', role: 'admin') unless User.find_by(email: 'admin@projectname.com')
