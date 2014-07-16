# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create(name: 'admin', description: 'God mode')
Role.create(name: 'guest', description: 'Slave mode')

Support.create(login: 'root', password: 'vsqgfhjkm', first_name: 'Sky', last_name: 'Dion', email: 'skydion@ukr.net', role_id: 1)
Support.create(login: 'ufo', password: 'vsqgfhjkm', first_name: 'Sky', last_name: 'Dion', email: 'ping@gmail.net', role_id: 2)
