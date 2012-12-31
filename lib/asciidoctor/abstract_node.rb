class Asciidoctor::AbstractNode
  # Public: Get the element which is the parent of this node
  attr_reader :parent

  # Public: Get the Asciidoctor::Document to which this node belongs
  attr_reader :document

  # Public: Get the Symbol context for this node
  attr_reader :context

  # Public: Get the id of this node
  attr_accessor :id

  # Public: Get the Hash of attributes for this node
  attr_reader :attributes

  def initialize(parent, context)
    @parent = parent
    if !parent.nil?
      @document = parent.is_a?(Asciidoctor::Document) ? parent : parent.document
    else
      @document = nil
    end
    @context = context
    @attributes = {}
  end

  def attr(name, default = nil)
    default.nil? ? @attributes.fetch(name.to_s, self.document.attr(name)) :
        @attributes.fetch(name.to_s, self.document.attr(name, default))
  end

  def attr?(name)
    @attributes.has_key?(name.to_s) || self.document.attr?(name)
  end

  def update_attributes(attributes)
    @attributes.update(attributes)
  end

  # Public: Get the Asciidoctor::Renderer instance being used for the
  # Asciidoctor::Document to which this node belongs
  def renderer
    @document.renderer
  end

end
