# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 1
TicketState.create(name: 'Waiting for staff responce')
# 2
TicketState.create(name: 'Waiting for customer')
# 3 .. 5
TicketState.create(name: 'On hold')
TicketState.create(name: 'Cancelled')
TicketState.create(name: 'Completed')

# 1
Role.create(name: 'admin', description: 'God mode')
# 2
Role.create(name: 'guest', description: 'Slave mode')

Support.create(login: 'root', password: 'vsqgfhjkm', first_name: 'Sky', last_name: 'Dion', email: 'skydion@ukr.net', role_id: 1)
Support.create(login: 'ufo', password: 'vsqgfhjkm', first_name: 'Ufo', last_name: 'Flaying', email: 'ufo@gmail.net', role_id: 2)
Support.create(login: 'ping', password: 'vsqgfhjkm', first_name: 'Ping', last_name: 'Dion', email: 'ping@user.net', role_id: 1)

Ticket.create(uuid: 'JFU489IMV657YBQ', created_at: '2014-07-15 07:05:32.342645', support_id: 1, ticket_state_id: 1,
              username: 'customer1', email: 'customer1@user.net', subject: 'help customer1', problem: 'problem customer1', updated_at: '2014-07-16 10:48:47.677646')

Ticket.create(uuid: 'WIH456BSD203KPA', created_at: '2014-07-15 09:17:30.972733', support_id: 2, ticket_state_id: 1,
              username: 'customer2', email: 'customer2@user.net', subject: 'help customer2', problem: 'problem customer2', updated_at: '2014-07-16 10:49:06.427582')

Ticket.create(uuid: 'YUL683NRZ745CAV', created_at: '2014-07-15 10:01:33.436916', support_id: 1, ticket_state_id: 1,
              username: 'customer3', email: 'customer3@user.net', subject: 'help customer3', problem: 'problem customer3', updated_at: '2014-07-16 10:49:15.167019')

Ticket.create(uuid: 'UIK107GAP893CTQ', created_at: '2014-07-16 09:54:32.524883', support_id: 2, ticket_state_id: 1,
              username: 'customer4', email: 'customer4@user.net', subject: 'help customer4', problem: 'problem customer4', updated_at: '2014-07-16 10:49:21.068174')
