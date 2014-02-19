express = require('express')
passport = require('passport')
flash = require('connect-flash')
pg = require('pg')

LocalStrategy = require('passport-local').Strategy

Sequelize = require('sequelize')

app = express()
app.use express.cookieParser()
app.use express.bodyParser()
app.use flash()
app.use express.session(secret: "so secret")
app.use passport.initialize()
app.use passport.session()
app.use app.router

sequelize = new Sequelize('users', 'postgres', 'postgres',
  host: '127.0.0.1'
  port: 5432
  dialect: 'postgres'
)

User = sequelize.define('user',
  username: Sequelize.STRING
  password: Sequelize.STRING
)
User.sync()


auth = {}
auth.localStrategy = new LocalStrategy(
  username: "username"
  password: "password"
, (username, password, done) ->
  User = require("./User").User
  User.find(username: username).success (user) ->
    unless user
      return done(null, false,
        message: "Nobody here by that name"
      )
    if user.password isnt password
      return done(null, false,
        message: "Wrong password"
      )
    done null,
      username: user.username

  return
)

auth.validPassword = (password) ->
  @password is password

auth.serializeUser = (user, done) ->
  done null, user
  return

auth.deserializeUser = (obj, done) ->
  done null, obj
  return


AuthController =
  login: passport.authenticate("local",
    successRedirect: "/"
    failureRedirect: "/loginerror"
  )
  loginSuccess: (req, res) ->
    res.json
      success: true
      user: req.session.passport.user

    return

  loginFailure: (req, res) ->
    res.json
      success: false
      message: "Invalid username or password."

    return

  logout: (req, res) ->
    req.logout()
    res.end()
    return


###
passport.serializeUser (user, done) ->
  done null, user.username

passport.deserializeUser (username, done) ->
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
            if username in usernames
              User = username
            db.end()
)
  
#  User.findById id, (err, user) ->
#    done err, user

passport.use new LocalStrategy((username, password, done) ->
  User.findOne
    username: username
  , (err, user) ->
    return done(err)  if err
    unless user
      return done(null, false,
        message: 'Incorrect username.'
      )
    unless user.validPassword(password)
      return done(null, false,
        message: 'Incorrect password.'
      )
    done null, user
)

module.exports = passport

###
