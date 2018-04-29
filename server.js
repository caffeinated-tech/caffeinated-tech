const express = require('express')

const app = express()

//Set content directories
app.use(express.static(__dirname + '/'))

// app.get('/', function(request, response) {
//     response.sendfile(htmlDir + 'turbocalendulator.html')
// })

const port = process.env.PORT || 5000
app.listen(port, function () {
  console.log("Listening on " + port)
})
