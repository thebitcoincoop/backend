pg = require 'pg'
conString = 'postgres://postgres:postgres@localhost:5432/users'
exports.client = new pg.Client(conString)


