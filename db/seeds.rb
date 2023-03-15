# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
u1 = User.create(email: 'user1@wallet.app', password: '12345678')
u2 = User.create(email: 'user2@wallet.app', password: '12345678')
u3 = User.create(email: 'user3@wallet.app', password: '12345678')
u4 = User.create(email: 'user4@wallet.app', password: '12345678')
t1 = Team.create(name: 'Team1', users: [u1, u2])
t2 = Team.create(name: 'Team2', users: [u3, u4])
w1 = Wallet.create(ownable: u1, balance: 20)
w2 = Wallet.create(ownable: u2, balance: 30)
w2 = Wallet.create(ownable: t1, balance: 80)
