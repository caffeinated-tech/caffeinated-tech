MongooseBcrypt = require('mongoose-bcrypt')

UserSchema = new mongoose.Schema
  email: 
    type: String
    required: true
    trim: true
  password: 
    type: String
    required: true
    trim: true
  admin:
    type: Boolean
    required: true
    default: false
,
  timestamps: true

# secure salted hashes of passwords
UserSchema.plugin MongooseBcrypt

User = mongoose.model 'User', UserSchema

module.exports = User