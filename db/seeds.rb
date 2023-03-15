# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def seed_stock(identifier, indices = 'NIFTY 50')
  quote = LatestStockPrice
    .new('price', "Indices=#{indices}&Identifier=#{identifier}").exec
  q = JSON.parse(quote).first
  if q.present?
    s = Stock.create(identifier: q['identifier'], symbol: q['symbol'])
    update_time = DateTime.strptime(q['lastUpdateTime'], '%d-%b-%Y %H:%M:%S')
    StockPrice.find_or_initialize_by(stock: s, update_time: update_time).
      update_attribute(:price, q['lastPrice'])
    s
  end
end

u1 = User.create(email: 'user1@wallet.app', password: '12345678')
u2 = User.create(email: 'user2@wallet.app', password: '12345678')
u3 = User.create(email: 'user3@wallet.app', password: '12345678')
u4 = User.create(email: 'user4@wallet.app', password: '12345678')

t1 = Team.create(name: 'Team1', users: [u1, u2])
t2 = Team.create(name: 'Team2', users: [u3, u4])

s1 = seed_stock('ADANIENTEQN')
s2 = seed_stock('BPCLEQN')


w1 = Wallet.create(ownable: u1, balance: 20000)
w2 = Wallet.create(ownable: u2, balance: 30000)
w3 = Wallet.create(ownable: t1, balance: 80000)
w4 = Wallet.create(ownable: t2, balance: 100000)
w5 = Wallet.create(ownable: s1, balance: 60000)
w6 = Wallet.create(ownable: s2, balance: 70000)
