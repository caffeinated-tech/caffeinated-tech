nodemailer = require('nodemailer')

sendEmail = (recipient, message) ->
  transporter = nodemailer.createTransport
    service: 'GandiMail',
    auth: 
      user: process.env.MAILER_ADDRESS
      pass: process.env.MAILER_PASSWORD

  mailOptions =
    from: '"Caffeinated Tech" <noreply@caffeinated.tech>'
    to: recipient
    subject: 'Message for caffeinated.tech'
    text: message

  transporter.sendMail mailOptions, -> null 
# VIEW_DIR = './public/views/profile/'

# SEND_FILE_OPTIONS = 
#   root: VIEW_DIR
#   dotfiles: 'deny'
#   headers: 
#     'x-sent': true

# render = (templateFile, data = {}) ->
#   path = VIEW_DIR + templateFile + '.ejs'
#   template = fs.readFileSync path, 'utf8'
#   EJS.render(template, data)

MailingListRouter = express()

# MailingListRouter.get '/', (req,res) ->
#   res.sendFile 'index.html', SEND_FILE_OPTIONS

MailingListRouter.post '/subscribe', (req,res) ->
  console.log 'subscrbed', req.body.email
  data = 
    email: req.body.email
    password: Math.random().toString()
  
  Models.User().save (err, user) ->
    sendEmail req.body.email, "Confirming your subscription to my mailing list"
    res.sendStatus 200

module.exports = MailingListRouter
