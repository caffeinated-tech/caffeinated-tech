PostSchema = new mongoose.Schema
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

PostSchema.methods.blurbHTML = ->
  """
    <section>
      <a href="v/blog/#{@id}/#{@slug}">
        <h3>
          #{@title}
        </h3>
      </a>
      <p>
        #{@blurb}
      </p>
    </section>
  """

Post = mongoose.model 'Post', PostSchema

module.exports = Post