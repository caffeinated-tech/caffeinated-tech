

AuthMiddleware = (req, res, next) ->
  # skip auth during development
  return next()
  return res.send(null) unless req.session.userId?
  Models.User.findOne
    _id: req.session.userId
  , (err, user) ->
    return res.send(null) if err or user is null
    next()

module.exports = AuthMiddleware