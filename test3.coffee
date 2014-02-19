Sequelize = require('sequelize')
sequelize = new Sequelize('users', 'postgres', 'postgres',
  host: '127.0.0.1'
  port: 5432
  dialect: 'postgres'
)


sequelize.query("SELECT username FROM users").success (myTableRows) ->
  console.log myTableRows[0]
  return
