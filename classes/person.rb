require_relative 'nameable'
require_relative 'base_decorator'
require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'
require_relative 'book'

class Person < Nameable
  attr_reader :id, :rentals
  attr_accessor :name, :age

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..10_000)
    @rentals = []
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_service?
    return true if of_age? || @parent_permission

    false
  end

  def correct_name
    @name
  end

  def rental(date, book)
    Rental.new(date, book, self)
  end

  private

  def of_age?
    return false if @age < 18

    true if @age >= 18
  end
end
