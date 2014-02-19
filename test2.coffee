db = require('./postgres').client

User = 'adam'

test2 = db.connect (err) ->
  if err
    console.error 'oops', err
  else
    db.query 'SELECT id, username, first_name, 
        last_name, superuser FROM users', (err, result) ->       
      if err
        console.error 'this is an error message', err
      else 
        output = result.rows
        username = (user.username for user in result.rows)
        console.log output
        console.log User in username 
        db.end()


