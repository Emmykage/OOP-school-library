class Book
  attr_reader :rentals, :id
  attr_accessor :title, :author

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
    @id = Random.rand(0...10_000)
  end
end
