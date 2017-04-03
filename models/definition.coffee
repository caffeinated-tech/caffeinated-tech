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

DefinitionSchema.methods.blurbHTML = ->
  """
    <section>
      <a href="v/glossary/#{@id}/#{@slug}">
        <h3>
          #{@title}
        </h3>
      </a>
      <p>
        #{@blurb}
      </p>
    </section>
  """

Definition = mongoose.model 'Definition', DefinitionSchema

module.exports = Definition