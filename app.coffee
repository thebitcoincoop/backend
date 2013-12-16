express = require('express')
engines = require('consolidate')


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


app.get('/', (req, res) ->
  res.render('user/dash')
)
app.get('/merchants', (req, res) ->
  res.render('user/merchants')
)


app.use((err, req, res, next) ->
  res.status(500)
  console.log(err)
  res.end()
)

app.listen(3000)
