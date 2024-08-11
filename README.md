# README

## Installation

rails credentials:edit
```
rapid_api:
  key: yourkeyhere
```
bundle install
rails db:drop db:create db:migrate db:seed
rails s


### Get Token
`curl -X POST localhost:3000/api/v1/session -d 'email=user1@wallet.app&password=12345678'`

### deposit

`curl -X POST localhost:3000/api/v1/users/deposit -H "token: <yourtoken>" -d 'entity_type=user&entity_query=user1@wallet.app&amount=900'`

`curl -X POST localhost:3000/api/v1/users/deposit -H "token: <yourtoken>" -d 'entity_type=team&entity_query=Team1&amount=900'`

`curl -X POST localhost:3000/api/v1/users/deposit -H "token: <yourtoken>" -d 'entity_type=stock&entity_query=VEDLEQN&amount=900'`

### withdraw

`curl -X POST localhost:3000/api/v1/users/withdraw -H "token: <yourtoken>" -d 'entity_type=user&entity_query=user1@wallet.app&amount=900'`

`curl -X POST localhost:3000/api/v1/users/withdraw -H "token: <yourtoken>" -d 'entity_type=team&entity_query=Team1&amount=900'`

`curl -X POST localhost:3000/api/v1/users/withdraw -H "token: <yourtoken>" -d 'entity_type=stock&entity_query=VEDLEQN&amount=900'`
