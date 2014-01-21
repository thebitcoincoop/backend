express = require('express')
engines = require('consolidate')
path = require('path')
#passport = require('./passport')
db = require('./postgres').client

app = express()
app.enable('trust proxy')
app.engine('html', require('mmm').__express)
app.set('view engine', 'html')
app.set('views', __dirname + '/views')
app.use(express.static(__dirname + '/public'))
app.use(require('connect-assets')(src: 'public'))
app.use(express.bodyParser())
app.use(express.cookieParser())
app.use(app.router)

test = require('./test').hi
#test2 = require('./test2').dbtest

app.get('/', (req, res) -> 
  res.render('dash',
    hello: 'Hello world',
    hi: test
    )
)

app.get('/merchants', (req, res) -> res.render('merchants'))

app.get('/users', (req, res) -> 
  db.connect (err) ->
    if err
      console.error 'oops', err
    else
      db.query 'SELECT id, username, first_name, 
        last_name, superuser FROM users', (err, result) -> 
        if err
          console.error 'this is an error message', err
        else
          result.rows
          users = result.rows
          res.render('users',
            users: users
          )
          db.end()
)


###
app.get('/users', (req, res) -> 
  db.connect (err) ->
    if err
      console.error 'oops', err
    else
      db.query 'SELECT username FROM users', (err, result) -> 
        if err
          console.error 'this is an error message', err
        else
          result.rows
          usernames = (user.username for user in result.rows)
          res.render('users',
            dbtest2: usernames[1]
          )
          db.end()
)###

app.use((err, req, res, next) ->
  res.status(500)
  console.log(err)
  res.end()
)

app.listen(3000)
