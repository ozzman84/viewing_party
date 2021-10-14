class Review
  attr_reader :author, :content
  def initialize(author, content)
    @author = author
    @content = content
  end
end
