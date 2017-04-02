PostSchema = new mongoose.Schema
  email: 
    type: String
    required: true
    trim: true
  slug: 
    type: String
    required: true
    trim: true
  blurb: String
  body: 
    type: String
    required: true
    trim: true
  tags: 
    type: String
    required: true
    trim: true
,
  timestamps: true

Post = mongoose.model 'Post', PostSchema

module.exports = Post