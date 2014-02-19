Sequelize = require('sequelize')
exports.sequelize = new Sequelize('users', 'postgres', 'postgres',
  host: '127.0.0.1'
  port: 5432
  dialect: 'postgres'
)
