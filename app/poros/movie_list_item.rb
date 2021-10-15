class MovieListItem
  attr_reader :id,
              :name,
              :vote_count

  def initialize(id, name, vote_count=nil)
    @id = id
    @name = name
    @vote_count = vote_count
  end
end
