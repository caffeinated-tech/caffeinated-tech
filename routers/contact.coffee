nodemailer = require('nodemailer')
VIEW_DIR = './public/views/contact/'

SEND_FILE_OPTIONS = 
  root: VIEW_DIR
  dotfiles: 'deny'
  headers: 
    'x-sent': true

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

sendContactForm = (opts)->
  emailBody = "Message from \"#{opts.name}\" (#{opts.email})\n---\n#{opts.message}"
  sendEmail "noreply@caffeinated.tech", emailBody
  sendEmail opts.email, emailBody if opts.sendCopy

render = (templateFile, data = {}) ->
  path = VIEW_DIR + templateFile + '.ejs'
  template = fs.readFileSync path, 'utf8'
  EJS.render(template, data)

ContactRouter = express()

ContactRouter.get '/', (req,res) ->
  res.sendFile 'index.html', SEND_FILE_OPTIONS

ContactRouter.post '/send_email', (req,res) ->
  console.log req.body
  sendContactForm req.body
  res.send 'ok'

module.exports = ContactRouter
