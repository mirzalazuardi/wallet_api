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

# invoke rake task stocks:update
Rake::Task['stocks:update'].invoke

s1 = Stock.first
s2 = Stock.last

w1 = Wallet.create(ownable: u1, balance: 20000)
w2 = Wallet.create(ownable: u2, balance: 30000)
w3 = Wallet.create(ownable: t1, balance: 80000)
w4 = Wallet.create(ownable: t2, balance: 100000)
w5 = Wallet.create(ownable: s1, balance: s1.last_price * 100)
w6 = Wallet.create(ownable: s2, balance: s2.last_price * 100)
