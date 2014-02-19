express = require('express')
engines = require('consolidate')
path = require('path')
passport = require('passport')
#sessions = require("./routes/sessions")(passport)
#db = require('./postgres').client
db = require('./postgres')

Sequelize = require('sequelize')
sequelize = new Sequelize('users', 'postgres', 'postgres',
  host: '127.0.0.1'
  port: 5432
  dialect: 'postgres'
)

app = express()
app.enable('trust proxy')
app.engine('html', require('mmm').__express)
app.set('view engine', 'html')
app.set('views', __dirname + '/views')
app.use(express.static(__dirname + '/public'))
app.use(require('connect-assets')(src: 'public'))
app.use(express.bodyParser())
app.use(express.cookieParser())
app.use(express.session(secret: 'satoshisidentityisasecret'))
app.use(passport.initialize())
app.use(passport.session())
app.use(app.router)


test = require('./test').hi

app.get('/', (req, res) -> 
  res.render('dash',
    hello: 'Hello world',
    hi: test
    )
)

app.get('/merchants', (req, res) -> res.render('merchants'))

app.get('/users', (req, res) -> 
 sequelize.query("SELECT id, username, first_name, 
        last_name, superuser FROM users").success (myTableRows) ->
  users = myTableRows
  res.render('users',
    users: users)
  return
  )

app.get('/login', (req, res) ->
  res.render(passport.AuthController.login,
  )
) # to be learned


app.use((err, req, res, next) ->
  res.status(500)
  console.log(err)
  res.end()
)

app.listen(3000)
