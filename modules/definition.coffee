DefinitionSchema = new mongoose.Schema
  title: 
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

Definition = mongoose.model 'Definition', DefinitionSchema

module.exports = Definition